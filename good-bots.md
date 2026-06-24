# Good Bots

To avoid having this middleware impact your SEO score, provide a value for `goodBots`. By default, no bots are allowed to crawl protected routes beyond the rate limit unless their second-level domain, such as `bing.com`, is configured as a good bot.

A good default value for `goodBots` is:

```yaml
enableGooglebotIPCheck: "true"
enableUptimeRobotBypass: "true"
goodBots: apple.com,archive.org,duckduckgo.com,facebook.com,google.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com
```

Google publishes bot IPs, so captcha-protect can use the Google API to let Google crawl the site unchallenged based on client IP. Enable this with:

```yaml
enableGooglebotIPCheck: "true"
```

UptimeRobot publishes its monitoring IP ranges at `https://api.uptimerobot.com/meta/ips`. Set `enableUptimeRobotBypass: "true"` to exempt those IPs; the list is fetched at startup and refreshed every 24 hours. The default is `"false"`.

If you set `protectParameters: "true"`, even good bots are not allowed to crawl protected routes when a URL parameter is on the request, such as `/foo?bar=baz`. This feature is meant to help protect faceted search pages.
