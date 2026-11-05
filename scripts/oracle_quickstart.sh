#!/usr/bin/env bash
# AulaClaw / 4Geeks — Oracle Linux VPS bootstrap.
# Does not install, stop, or modify n8n; uses private Node; no public port changes.
set -Eeuo pipefail

fail() { printf 'AULACLAW BLOQUEADO: %s\n' "$*" >&2; exit 1; }
command -v curl >/dev/null || fail 'Falta curl.'
command -v git >/dev/null || fail 'Falta git.'
command -v sudo >/dev/null || fail 'Ejecuta desde usuario SSH normal con sudo, no como root.'
command -v openssl >/dev/null || fail 'Falta openssl.'
command -v docker >/dev/null || fail 'No encontre Docker. No instale nada automaticamente sobre n8n.'
[ "$(id -u)" -ne 0 ] || fail 'No ejecutes OpenClaw como root. Usa tu usuario SSH de Oracle.'
sudo docker info >/dev/null 2>&1 || fail 'Docker no responde. Comprueba sudo docker info.'
if [ -f "$HOME/.openclaw/openclaw.json" ]; then
  fail 'Ya hay una configuracion OpenClaw de este usuario. Evito sobrescribirla; usa un usuario Linux academico separado.'
fi
if sudo docker container inspect aula4geeks-litellm >/dev/null 2>&1; then
  fail 'Ya existe el contenedor aula4geeks-litellm. No lo voy a sustituir.'
fi
if command -v ss >/dev/null && ss -H -ltn '( sport = :4000 )' | grep -q .; then
  fail 'El puerto 4000 ya esta ocupado. No modificare el servicio existente.'
fi

printf 'AulaClaw: host=%s arch=%s usuario=%s\n' "$(hostname)" "$(uname -m)" "$(id -un)"
printf 'No se cambiara n8n ni se abriran puertos publicos.\n'

# Keep provider credentials outside the public repository.
config_dir="$HOME/.config/aula4geeks"
umask 077
mkdir -p "$config_dir"
if [ -f "$config_dir/litellm.env" ]; then
  fail "Ya existe $config_dir/litellm.env. No lo sobrescribire."
fi
printf 'Pega solo aqui tu GEMINI_API_KEY de Google AI Studio (no se mostrara): ' >/dev/tty
IFS= read -r -s GEMINI_API_KEY </dev/tty || fail 'No se pudo leer la clave desde la terminal SSH.'
printf '\n' >/dev/tty
[ -n "$GEMINI_API_KEY" ] || fail 'La clave Gemini no puede estar vacia.'
[[ "$GEMINI_API_KEY" =~ ^[a-zA-Z0-9_.-]+$ ]] || fail 'La clave tiene caracteres inesperados; revisa lo copiado.'
LITELLM_MASTER_KEY="sk-$(openssl rand -hex 32)"
printf 'GEMINI_API_KEY=%s\nLITELLM_MASTER_KEY=%s\n' "$GEMINI_API_KEY" "$LITELLM_MASTER_KEY" > "$config_dir/litellm.env"
chmod 600 "$config_dir/litellm.env"
unset GEMINI_API_KEY
cat > "$config_dir/litellm.yaml" <<'YAML'
model_list:
  - model_name: aula-free
    litellm_params:
      model: gemini/gemini-3.5-flash-lite
      api_key: os.environ/GEMINI_API_KEY
general_settings:
  master_key: os.environ/LITELLM_MASTER_KEY
YAML
chmod 600 "$config_dir/litellm.yaml"

# Modern official multi-arch image. Port bound to loopback only.
sudo docker run -d --name aula4geeks-litellm --restart unless-stopped \
  --publish 127.0.0.1:4000:4000 \
  --env-file "$config_dir/litellm.env" \
  --volume "$config_dir/litellm.yaml:/app/config.yaml:ro" \
  ghcr.io/berriai/litellm:main-stable --config /app/config.yaml --port 4000 >/dev/null

ready=0
for _ in $(seq 1 30); do
  if curl --silent --fail --max-time 2 \
       -H "Authorization: Bearer ${LITELLM_MASTER_KEY}" \
       http://127.0.0.1:4000/v1/models | grep -q 'aula-free'; then
    ready=1
    break
  fi
  sleep 2
done
[ "$ready" -eq 1 ] || fail 'LiteLLM no responde con aula-free. Consulta: sudo docker logs aula4geeks-litellm (sin compartir secretos).'
# An advertised model does not prove the upstream Gemini key works.
if ! curl --silent --fail --max-time 60 \
     --header "Authorization: Bearer ${LITELLM_MASTER_KEY}" \
     --header 'Content-Type: application/json' \
     --data '{"model":"aula-free","messages":[{"role":"user","content":"Responde OK"}],"max_tokens":30}' \
     http://127.0.0.1:4000/v1/chat/completions | grep -q '"choices"'; then
  fail 'LiteLLM abre, pero Gemini no responde. Verifica cuota y clave en AI Studio.'
fi
printf 'AULACLAW: LiteLLM y Gemini respondieron en 127.0.0.1:4000.\n'

# Official user-private installer: does not replace Node used by other services.
curl -fsSL --proto '=https' --tlsv1.2 https://openclaw.ai/install-cli.sh | bash -s -- --prefix "$HOME/.local/aula4geeks" --no-onboard
export PATH="$HOME/.local/aula4geeks/bin:$PATH"
command -v openclaw >/dev/null || fail 'CLI no disponible despues de instalar.'

repo="$HOME/4geeks-aulaclaw"
if [ -e "$repo" ]; then
  fail "Ya existe $repo. No lo modificare."
fi
git clone --depth 1 https://github.com/Picazo333/openclaw-Picazo333.git "$repo"
workspace="$HOME/.openclaw/workspace"
mkdir -p "$workspace"
cp -a "$repo/.openclaw/workspace/." "$workspace/"
test -f "$workspace/skills/brief-de-trabajo/SKILL.md" || fail 'Falta la skill brief-de-trabajo.'
test -f "$workspace/skills/bloque-de-ejecucion/SKILL.md" || fail 'Falta la skill bloque-de-ejecucion.'

# Noninteractive provider wiring. Only local state has the master key.
openclaw onboard --non-interactive --accept-risk --skip-health \
  --auth-choice litellm-api-key \
  --litellm-api-key "$LITELLM_MASTER_KEY" \
  --custom-base-url 'http://127.0.0.1:4000/v1' \
  --install-daemon
openclaw config set agents.defaults.model.primary litellm/aula-free
sudo loginctl enable-linger "$(id -un)" >/dev/null 2>&1 || true
if ! openclaw health >/dev/null 2>&1; then
  openclaw gateway start || true
  sleep 3
fi
openclaw health || fail 'El gateway no esta saludable; diagnosticar antes de seguir.'
printf '\nAULACLAW: Gateway funcional.\n'
printf 'Ejecuta: openclaw gateway status; openclaw doctor; openclaw skills list\n'
printf 'NO publiques ~/.config/aula4geeks ni ~/.openclaw/openclaw.json.\n'