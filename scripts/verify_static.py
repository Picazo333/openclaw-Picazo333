#!/usr/bin/env python3
"""Validación estática; NO reemplaza pruebas de OpenClaw, canales ni servicios."""
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[1]
workspace = root / ".openclaw" / "workspace"
required = [
    root / "README.md", root / "SKILLS_DESIGN.md", root / ".gitignore",
    root / "openclaw-connection" / "notes.md",
    *(workspace / x for x in ["IDENTITY.md", "SOUL.md", "AGENTS.md", "USER.md", "TOOLS.md"]),
]
for skill in ["brief-de-trabajo", "bloque-de-ejecucion"]:
    p = workspace / "skills" / skill / "SKILL.md"
    required.append(p)
    if p.exists():
        value = p.read_text(encoding="utf-8")
        if not value.startswith("---\n") or f"name: {skill}" not in value or "description:" not in value:
            print(f"ERROR metadata skill: {p}")
            sys.exit(1)
missing = [p for p in required if not p.exists()]
if missing:
    print("FALTAN ARCHIVOS:")
    print("\n".join(str(p.relative_to(root)) for p in missing))
    sys.exit(1)
print("PASS: archivos academicos y metadata de skills presentes.")
print("UNVERIFIED: runtime, LiteLLM, VPS/SSH, Telegram, Zapier, Docs, Calendar, doctor y capturas.")
