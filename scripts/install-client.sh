#!/bin/sh
set -eu

service_url="https://penn-ga-mcp-232535706847.us-east1.run.app"
mcp_url="${service_url}/mcp"
connector_name="penn-google-analytics"
helper_dir="${HOME}/.local/bin"
helper_path="${helper_dir}/penn-ga-mcp-auth"
config_path="${CODEX_HOME:-${HOME}/.codex}/config.toml"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: https://brew.sh" >&2
  exit 1
fi

if ! command -v gcloud >/dev/null 2>&1; then
  brew install --cask google-cloud-sdk
fi

if ! command -v jq >/dev/null 2>&1; then
  brew install jq
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex must be installed before running this installer." >&2
  exit 1
fi

echo "Sign in with the Google account authorized for the Penn GA connector."
gcloud auth login

mkdir -p "$helper_dir"
{
  echo '#!/bin/sh'
  echo 'set -eu'
  echo 'gcloud auth print-identity-token | jq -R '\''{Authorization: ("Bearer " + .)}'\'''
} > "$helper_path"
chmod 700 "$helper_path"

codex mcp remove "$connector_name" >/dev/null 2>&1 || true
codex mcp add "$connector_name" --url "$mcp_url"

HELPER_PATH="$helper_path" perl -0pi -e '
  s{(\[mcp_servers\.penn-google-analytics\]\nurl = "[^"]+"\n)}
   {$1 . qq{http_headers_helper = "$ENV{HELPER_PATH}"\n}}e
' "$config_path"

identity_token="$(gcloud auth print-identity-token)"
status="$(curl -sS -H "Authorization: Bearer ${identity_token}" "${service_url}/health" | jq -r '.status // empty')"

if [ "$status" != "ok" ]; then
  account="$(gcloud auth list --filter=status:ACTIVE --format='value(account)')"
  echo "The connector rejected ${account}. Ask the owner to authorize that exact Google email." >&2
  exit 1
fi

account="$(gcloud auth list --filter=status:ACTIVE --format='value(account)')"
echo "Penn Today Analytics is connected for ${account}."
echo "Restart Codex, then ask an analytics question in a new task."
