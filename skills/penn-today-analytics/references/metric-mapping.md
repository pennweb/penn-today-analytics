# Penn Today analytics metric mapping

Use this guide when translating natural-language questions or comparing GA4 with Chartbeat.

| User concept | GA4 metric/dimension | Chartbeat field | Notes |
| --- | --- | --- | --- |
| Page views | `screenPageViews` | `page_views` | Closest comparison, but collection rules differ. |
| Users/readers | `totalUsers` or `activeUsers` | `page_uniques` | Not equivalent identity models; label the selected GA4 metric. |
| Sessions/visits | `sessions` | No direct page-report equivalent | Do not compare as if equivalent. |
| Engaged time | `userEngagementDuration` or `averageSessionDuration` | `page_total_time` or `page_avg_time` | Confirm whether the question is per user, session, or page. |
| Day | `date` | `tz_day` | Use America/New_York boundaries. |
| Page path | `pagePath` | `path` | Normalize query strings and trailing slashes before joining. |
| Device | `deviceCategory` | `device` | Category labels may require normalization. |
| Referrer type | `sessionDefaultChannelGroup` or source/medium | `referrer_type` | These taxonomies are not one-to-one. |
| New/returning | `newVsReturning` | `visit_frequency` | Definitions differ; use directionally and explain. |

## Variance formulas

- Absolute variance: `GA4 - Chartbeat`.
- Percentage above Chartbeat: `(GA4 - Chartbeat) / Chartbeat * 100`.
- Ratio: `GA4 / Chartbeat`.
- Views per session: `GA4 screenPageViews / GA4 sessions`.

Always name the denominator. If Chartbeat is zero, report the absolute difference and do not calculate a percentage or ratio.

## Common interpretation checks

1. Confirm identical inclusive dates and timezone.
2. Exclude or separately label the current partial day.
3. Check whether consent gating delays or suppresses one tracker.
4. Compare mobile and desktop separately.
5. Compare new and returning audiences when available.
6. Check views per session before asserting duplicate GA4 firing.
7. Inspect path-level outliers before attributing a sitewide difference.
