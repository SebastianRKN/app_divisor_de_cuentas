# Procedencia de los artefactos
Se ejecutó uv tool install specify-cli, versión instalada 1.0.13.
Se ejecutó realmente:
specify init . --integration codex --script ps --non-interactive --force --ignore-agent-tools

La CLI instaló scripts, plantillas y .agents/skills/speckit-*/SKILL.md.
Codex leyó y siguió esas skills en esta misma sesión; los documentos son redactados por
el agente conforme a las plantillas, no por un generador autónomo ni por otro modelo.
No se fingió ejecutar un slash command: esta integración usa skills $speckit-*.
Se eligió .specify como feature_directory para respetar los nombres solicitados.
memory/constitution.md es la ubicación nativa y constitution.md su copia de entrega.
El usuario autoriza el flujo completo; no se detiene entre fases a pedir confirmaciones.
No se agregan ramas de feature ni principios fuera de los solicitados.
