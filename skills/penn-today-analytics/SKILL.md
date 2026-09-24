---
name: penn-today-analytics
description: Query Penn Today Google Analytics 4 and Chartbeat data from natural-language requests. Use for traffic, page views, users, sessions, events, referrals, devices, content performance, consent effects, double-trigger investigations, and GA4-versus-Chartbeat comparisons.
---

# Penn Today analytics

Use the read-only `penn-google-analytics` MCP connector. Never invent analytics values or silently substitute a different property, metric, date range, or data source.

## Connection

1. Prefer the tools exposed by `penn-google-analytics`.
2. If the connector is unavailable, tell the user that teammate setup is required. Direct them to run `scripts/install-client.sh` from this plugin, then restart Codex and begin a new task.
3. If the connector rejects the signed-in Google identity, report the exact active email when available and ask the connector owner to authorize that address. Do not request or distribute a service-account key or Chartbeat API key.

## Workflow

1. Resolve relative dates using the current date and `America/New_York`. State the exact inclusive date range in the answer.
2. Use `get_account_summaries` when the GA4 property is not already established. If exactly one relevant Penn Today property is available, use it. If several plausible properties remain, ask the user to choose.
3. For GA4 historical questions, call `run_report`. For current activity, call `run_realtime_report`.
4. For Chartbeat historical questions, call `chartbeat_historical_report`. Use the `chartbeat_live_*` tools only for current traffic.
5. For cross-source comparisons, request matching dates, timezone, and the closest comparable metric and dimension. Read `references/metric-mapping.md` before interpreting differences.
6. Calculate totals, absolute differences, percentage differences, and ratios from returned values. Label the denominator for every percentage.
7. Separate measured facts from interpretation. Explain likely causes as hypotheses unless the data directly establishes them.

## Reporting rules

- Treat GA4 `screenPageViews` as the default page-view measure. Do not substitute event count unless the user explicitly asks about events.
- Treat Chartbeat `page_views` as the closest historical comparison, while noting that the systems have different collection and identity rules.
- When comparing a completed month with the current month, either compare equal day counts or clearly label a full-month versus month-to-date comparison.
- When investigating duplicate firing, include views, sessions, and views per session where available. A large source-to-source gap alone does not prove duplicate firing.
- When investigating consent changes, segment by date, device category, new versus returning users when available, and the consent change boundary.
- Keep tables compact. Include source, metric, exact period, value, variance, and the key caveat.
- Mention sampling, thresholds, quota limits, incomplete current-day data, or missing rows when the tool reports them.

## Safety and scope

- The connector is read-only. Do not represent that it can edit GA4, GTM, OneTrust, or Chartbeat configuration.
- Do not reveal tokens, API keys, Cloud Run credentials, service-account details beyond the public runtime identity, or raw authorization headers.
- Do not add users to the connector unless the user explicitly asks and the authorized administration workflow is available.
