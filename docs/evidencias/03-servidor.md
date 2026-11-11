# Evidencia 03 — servidor (capturada por SSH 2026-11-11T02:02:39+00:00)

```text
$ whoami; hostname; hostname -I
root
bc-vps-410
161.35.49.214
$ echo $SSH_CONNECTION (IP cliente enmascarada)
x.x.x.x 26443 161.35.49.214 22
$ cat /etc/os-release | head -2
PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
$ nproc; free -m; df -h /
1
               total        used        free      shared  buff/cache   available
Mem:             957         670         106           3         180         135
Swap:           2047         936        1111
/dev/vda1        25G  7.6G   17G  32% /
$ openclaw --version
OpenClaw 2026.9.7 (c074824)
$ systemctl --user is-active openclaw-gateway
active
$ curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:18789/
200
$ openclaw config get agents.defaults.model.primary
litellm/online/openrouter/deepseek/deepseek-v4-flash
$ openclaw config get models.providers.litellm.baseUrl
https://llm.4geeks.ai/v1
$ openclaw config get hooks.internal.entries
{
  "session-memory": {
    "enabled": true
  }
}
$ ls -la ~/.openclaw/.env (permisos)
-rw------- root /root/.openclaw/.env
```
