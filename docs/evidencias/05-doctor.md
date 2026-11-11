# 05 — openclaw doctor (salida íntegra, redactada)

```text
$ openclaw doctor --non-interactive
┌  OpenClaw doctor
│
◇  Startup optimization ────────────────────────────────────────────────╮
│                                                                       │
│  - NODE_COMPILE_CACHE is not set; repeated CLI runs can be slower on  │
│    small hosts (Raspberry Pi/VM).                                     │
│  - OPENCLAW_NO_RESPAWN is not set to 1; set it when you want routine  │
│    gateway restarts to stay in-process instead of handing off to a    │
│    managed supervisor.                                                │
│  - Suggested env for low-power hosts:                                 │
│    export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache          │
│    mkdir -p /var/tmp/openclaw-compile-cache                           │
│    export OPENCLAW_NO_RESPAWN=1                                       │
│                                                                       │
├───────────────────────────────────────────────────────────────────────╯
[warning] core/doctor/node-hosting-preconditions gateway.bind - Gateway is only bound to loopback. Set gateway.publicOrigin to your public HTTPS origin, configure plugins.entries.device-pair.config.publicUrl, enable tailscale serve, or set gateway.bind=lan.
  fix: If an edge proxy fronts node onboarding, allow /j/* and /__openclaw__/worker without edge identity auth, and preserve WebSocket upgrade on /__openclaw__/worker. Both routes enforce their own credentials.
[state/agent-db] agent database integrity gate
│
◇  State integrity ────────────────────────────────────────────────────╮
│                                                                      │
│  - OAuth dir not present (~/.openclaw/credentials). Skipping create  │
│    because no WhatsApp/pairing channel config is active.             │
│                                                                      │
├──────────────────────────────────────────────────────────────────────╯
│
◇  Backups ─────────────────────────────────────────────────────────────╮
│                                                                       │
│  No successful backup is recorded.                                    │
│  Create one now with openclaw backup create.                          │
│  Schedule versioned backups with openclaw backup enable --repository  │
│  <dir>.                                                               │
│                                                                       │
├───────────────────────────────────────────────────────────────────────╯
│
◇  Gateway heap ──────────────────────────────────────────────────────────╮
│                                                                         │
│  service argv: --max-old-space-size=717; installer recommendation: 717  │
│  MiB old space (957 MiB physical capacity; adaptive cap 8192 MiB;       │
│  native headroom cap 717 MiB); runtime V8 ceiling: not measured         │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────╯
│
◇  Host desktop ────────────────────────────────────────────────────╮
│                                                                   │
│  disabled; enable the Desktop lab with desktop.host.enabled=true  │
│                                                                   │
├───────────────────────────────────────────────────────────────────╯
│
◇  Security ─────────────────────────────────────────────────────────────╮
│                                                                        │
│  - WARNING: openclaw.json contains plaintext secret-bearing config     │
│    fields.                                                             │
│    Migrate them to SecretRefs with openclaw secrets configure or       │
│    openclaw secrets apply, then verify with openclaw secrets audit     │
│    --check.                                                            │
│    Paths: channels.telegram.botToken                                   │
│    Agents or workspace tools that can read config files may see these  │
│    API keys/tokens.                                                    │
│  - Run: openclaw security audit --deep                                 │
│                                                                        │
├────────────────────────────────────────────────────────────────────────╯
│
◇  GitHub projects ────────────────────────────────────────────────────────╮
│                                                                          │
│  Prefer gateway.controlUi.github.token for Gateway-owned GitHub project  │
│  access, or set GH_TOKEN/GITHUB_TOKEN in the shared Gateway process      │
│  environment. Without either, search is public-only.                     │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────╯
│
◇  Browser relay authentication ──────────────────────────────────────────╮
│                                                                         │
│  - Legacy Browser Relay Authentication is enabled                       │
│    (browser.extensionRelay.allowLegacyAuth=true).                       │
│  - Update paired Chrome extensions and external CDP clients to Browser  │
│    Relay Authentication v2, then set                                    │
│    browser.extensionRelay.allowLegacyAuth=false.                        │
│  - V2 clients never downgrade to legacy authentication.                 │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────╯
│
◇  Skills ─────────────────────────────────────────────────────────────────╮
│                                                                          │
│  30 allowed skills are not usable in this environment (missing           │
│  binaries, env vars, or config).                                         │
│  - 1password, blogwatcher, blucli, camsnap, coding-agent, eightctl,      │
│    gemini, gh-issues, gifgrep, github, gog, goplaces, himalaya,          │
│    mcporter, model-usage, nano-pdf, obsidian, openai-whisper,            │
│    openai-whisper-api, openhue, oracle, ordercli, sag, sherpa-onnx-tts,  │
│    songsee, sonoscli, spotify-player, summarize, trello, xurl            │
│  Disable unused skills: openclaw doctor --fix                            │
│  Inspect details: openclaw skills check --agent <id> or openclaw skills  │
│  info <name> --agent <id>                                                │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────╯
│
◇  TOOLS.md migration preview ──────────────────────────────────────╮
│                                                                   │
│  ~/.openclaw/workspace/TOOLS.md will be archived and merged into  │
│  AGENTS.md when customized.                                       │
│                                                                   │
├───────────────────────────────────────────────────────────────────╯
│
◇  Memory search ───────────────────────────────────────────────────────╮
│                                                                       │
│  Memory search provider is set to "openai" but no API key was found.  │
│  Semantic recall will not work without a valid API key.               │
│                                                                       │
│                                                                       │
│  Fix (pick one):                                                      │
│  - Set OPENAI_API_KEY in your environment                             │
│  - Configure credentials: openclaw configure --section model          │
│  - To disable: openclaw config set memory.search.enabled false        │
│                                                                       │
│  Verify: openclaw memory status --deep                                │
│                                                                       │
├───────────────────────────────────────────────────────────────────────╯
│
└  Doctor complete.

[exit=0]
```
