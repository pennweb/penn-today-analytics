# Penn Today Analytics

Private Codex plugin for natural-language reporting across Penn Today's GA4 and Chartbeat data.

## Team setup

1. Install the shared private plugin in Codex.
2. Ask the connector owner to authorize the teammate's exact Google email.
3. Run `scripts/install-client.sh` on macOS.
4. Restart Codex and start a new task.

Each person signs in with their own Google account. The connector uses short-lived identity tokens. The GA service-account key and Chartbeat API credential are never distributed through this plugin.

## Example questions

- How was traffic yesterday?
- Compare GA4 and Chartbeat over the past week.
- Which pages gained the most traffic this month?
- Did page views double fire after a release?
- How did consent gating affect mobile and new visitors?
