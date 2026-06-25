# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a **training course** for "Platform Engineering & Kubernetes" delivered by Mojtaba Imani. It is not application source code, it is teaching material: presentation slides, reference notes, and self-contained hands-on lab manifests that participants run against a local minikube cluster. There is no build, no test suite, and no CI. Default to treating edits as authoring/teaching changes, not software changes.

The five modules mirror the structure described in `introduction-email.md`: Platform Engineering & IDPs, Kubernetes Core, Advanced Workloads, Helm & Kustomize, and CKA Deep Dive. Workshop prerequisites: Docker, Minikube, kubectl, Helm, K9s, Git.

## Layout

Top-level directories use a `N.<topic>` numeric prefix that encodes teaching order (this is also why individual lab files use prefixes like `3.1.deployment.yaml`, `3.2.deployment.OOMKilled.yaml`, etc.). Preserve these prefixes when adding new files, the ordering is referenced in the slides.

- `slides/` — Marp markdown decks (`1.platform-engineering.md` ... `5.cka-troubleshooting.md`) plus their rendered `.html` siblings. The `.html` files are build outputs of the `.md` files via Marp, regenerate them rather than hand-editing.
- `1.kubernetes/` — Raw Kubernetes YAML labs (Pods, Deployments, Services, ConfigMaps, Secrets, StatefulSets, Jobs, NetworkPolicies, RBAC, etc.). Each manifest is **self-contained**: relevant `kubectl` commands are kept as commented lines at the bottom of the same file so participants can copy them inline. Keep this convention when adding examples.
- `2.helm/` — Helm walkthroughs: `1.commands/helm-commands.sh` (repo/CLI cheatsheet), `2.emptychart/` (skeleton), `3.nginx/` (working chart) plus `nginx-values-dev.yaml` / `nginx-values-prod.yaml` at the parent level for env demos.
- `3.kustomize/` — `1.simple/` and `2.advanced/`, both with the canonical `base/` + `overlays/{dev,test,prod}` structure. Each has its own README describing the demo.
- `5.gitops/` — ArgoCD demo skeleton (`apps/`, `bootstrap/`, `manifests/webapp/{base,overlays}`).
- Root markdown (`5.kubernetes-basics.md`, `2.platform-engineering.md`, `introduction-email.md`, `notes.md`, `notes2.md`) — long-form reference content and instructor notes. The numbered prefixes here are legacy and do not need to be kept consistent with `slides/`.
- `theme.css`, `.vscode/settings.json` — Marp theme wiring. The VS Code Marp extension is configured to pull the Xebia theme from a remote URL; the local `theme.css` is a reference copy of that theme.

## Working with the slides (Marp)

Slides are [Marp](https://marp.app/) markdown with frontmatter (`marp: true`, `theme: gaia` or `theme: xebia`). To regenerate the HTML next to a deck:

```bash
npx @marp-team/marp-cli slides/2.kubernetes-core.md
# or for a PDF
npx @marp-team/marp-cli slides/2.kubernetes-core.md --pdf
```

When editing decks, `---` on its own line is a slide break, do not insert one mid-thought. The Marp extension previews live in VS Code using the configured theme.

## Working with the lab manifests

Participants run everything against a local minikube cluster, so when adding or modifying labs:

- Keep manifests minimal and readable, optimize for being explained line-by-line, not for production hardening.
- Append the relevant `kubectl` invocations as `#` comments at the bottom of the YAML, matching the style in `1.kubernetes/1.pod.yaml`.
- For Helm/Kustomize examples, mirror existing conventions (`commands.sh` scripts that list the demo command sequence; base + overlay split for Kustomize).
- The Helm chart in `2.helm/3.nginx/` is intentionally tiny (only `Chart.yaml`, `values.yaml`, and `templates/{deployment,configmap}.yaml`), do not scaffold it out with `helm create` boilerplate.

## Style and conventions

- Never use em dashes (`—`) or en dashes (`–`) in any text. Use commas, semicolons, colons, or separate sentences.
- In prose (markdown, slide content, comments), one paragraph = one line. Do not soft-wrap sentences with mid-paragraph hard breaks, the editor handles visual wrapping and hard wraps make diffs noisier.
- For charts, prefer mermaid in ```mermaid``` fenced blocks; for ASCII diagrams use the box-drawing characters (`┌ ┐ └ ┘ ─ │ ├ ┤ ┬ ┴ ┼`).
- Shell scripts in this repo (e.g. `2.helm/1.commands/helm-commands.sh`) are read aloud as much as executed, keep them commented and runnable from the repo root.
