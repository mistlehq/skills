#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_root="$repo_root/skills"

resolve_home() {
  local home_dir="${HOME:-}"
  local user_name="${USER:-}"

  if [[ -n "$home_dir" ]]; then
    printf '%s\n' "$home_dir"
    return
  fi

  if [[ -z "$user_name" ]] && command -v id >/dev/null 2>&1; then
    user_name="$(id -un 2>/dev/null || true)"
  fi

  if [[ -n "$user_name" ]] && command -v getent >/dev/null 2>&1; then
    home_dir="$(getent passwd "$user_name" 2>/dev/null | cut -d: -f6 || true)"
  fi

  if [[ -z "$home_dir" ]] && command -v id >/dev/null 2>&1 && [[ "$(id -u 2>/dev/null || true)" == "0" ]]; then
    home_dir="/root"
  fi

  if [[ -z "$home_dir" ]]; then
    home_dir="/tmp/mistle-agent-home"
  fi

  printf '%s\n' "$home_dir"
}

prepare_environment() {
  HOME="$(resolve_home)"
  export HOME

  XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_CONFIG_HOME

  CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
  export CODEX_HOME
}

usage() {
  cat <<'EOF'
Usage: ./install.sh [skill...]

Install skills from this checkout into the config-level skills directory for
the single agent runtime installed in the current environment.

If no skill names are provided, all first-level skills under ./skills are
installed.
EOF
}

detect_skills_root() {
  local has_codex="no"
  local has_opencode="no"

  if command -v codex >/dev/null 2>&1; then
    has_codex="yes"
  fi

  if command -v opencode >/dev/null 2>&1; then
    has_opencode="yes"
  fi

  if [[ "$has_codex" == "yes" && "$has_opencode" == "yes" ]]; then
    echo "Both codex and opencode are installed; expected exactly one runtime." >&2
    exit 1
  fi

  if [[ "$has_codex" == "yes" ]]; then
    printf '%s\n' "$CODEX_HOME/skills"
    return
  fi

  if [[ "$has_opencode" == "yes" ]]; then
    printf '%s\n' "$XDG_CONFIG_HOME/opencode/skills"
    return
  fi

  echo "Neither codex nor opencode is installed." >&2
  exit 1
}

sanitize_skill_name() {
  local raw="$1"
  local sanitized

  sanitized="$(printf '%s' "$raw" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9._]+/-/g; s/^[.-]+//; s/[.-]+$//')"

  if [[ -z "$sanitized" ]]; then
    echo "Invalid skill name: $raw" >&2
    exit 1
  fi

  printf '%s\n' "$sanitized"
}

resolve_skill_dir() {
  local requested="$1"

  case "$requested" in
    /*|*../*|../*|*/..|..)
      echo "Unsafe skill path: $requested" >&2
      exit 1
      ;;
  esac

  case "$requested" in
    */*)
      printf '%s\n' "$repo_root/$requested"
      ;;
    *)
      printf '%s\n' "$source_root/$requested"
      ;;
  esac
}

collect_default_skills() {
  local skill_dir

  for skill_dir in "$source_root"/*; do
    [[ -d "$skill_dir" && -f "$skill_dir/SKILL.md" ]] || continue
    printf '%s\n' "$(basename "$skill_dir")"
  done
}

install_skill() {
  local requested="$1"
  local skill_dir
  local skill_name
  local dest

  skill_dir="$(resolve_skill_dir "$requested")"

  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "Missing SKILL.md for skill: $requested" >&2
    exit 1
  fi

  skill_name="$(sanitize_skill_name "$(basename "$skill_dir")")"
  dest="$skills_root/$skill_name"

  mkdir -p "$skills_root"
  rm -rf "$dest"
  cp -R "$skill_dir" "$dest"
  echo "Installed $skill_name -> $dest"
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

prepare_environment
skills_root="$(detect_skills_root)"

if [[ "$#" -eq 0 ]]; then
  skills=()
  while IFS= read -r skill; do
    skills+=("$skill")
  done < <(collect_default_skills)
else
  skills=("$@")
fi

if [[ "${#skills[@]}" -eq 0 ]]; then
  echo "No skills found under $source_root" >&2
  exit 1
fi

for skill in "${skills[@]}"; do
  install_skill "$skill"
done
