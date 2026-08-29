# SEO And Monitoring Bypasses

Captcha Protect can bypass known crawlers and monitoring services before a challenge is served. Keep SEO crawler bypasses separate from monitoring bypasses so each setting has an obvious purpose.

## SEO

Use `goodBots` for search, social, archive, and research crawlers that should be allowed to crawl protected routes. Common Crawl is handled separately by the default-enabled `enableCommonCrawlIPCheck`; Google crawler ranges can be enabled with `enableGooglebotIPCheck`.

If you set `protectParameters: "true"`, `goodBots`, Google crawler IPs, and Common Crawl IPs are still challenged when a URL parameter is present, such as `/search?field=value`. This protects faceted search pages and other expensive query combinations.

Captcha Protect fetches Common Crawl's published CCBot ranges from `https://index.commoncrawl.org/ccbot.json` at startup and every 24 hours. It expands each IPv4 range and keeps only addresses whose forward-confirmed reverse DNS belongs to `commoncrawl.org`. Published IPv6 ranges are loaded as supplied. Set `enableCommonCrawlIPCheck: "false"` to disable this bypass.

=== "Structured (YAML)"

    ```yaml
    goodBots:
      - apple.com
      - archive.org
      - duckduckgo.com
      - facebook.com
      - google.com
      - instagram.com
      - kagibot.org
      - linkedin.com
      - msn.com
      - openalex.org
      - twitter.com
      - x.com
    enableCommonCrawlIPCheck: "true"
    enableGooglebotIPCheck: "true"
    protectParameters: "false"
    ```

=== "Structured (TOML)"

    ```toml
    goodBots = [
      "apple.com",
      "archive.org",
      "duckduckgo.com",
      "facebook.com",
      "google.com",
      "instagram.com",
      "kagibot.org",
      "linkedin.com",
      "msn.com",
      "openalex.org",
      "twitter.com",
      "x.com",
    ]
    enableCommonCrawlIPCheck = "true"
    enableGooglebotIPCheck = "true"
    protectParameters = "false"
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,duckduckgo.com,facebook.com,google.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableCommonCrawlIPCheck=true"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectParameters=false"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,duckduckgo.com,facebook.com,google.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableCommonCrawlIPCheck=true",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectParameters=false"
    ]
    ```

## Monitoring

Use `enableUptimeRobotBypass` when UptimeRobot should reach protected routes without a challenge. UptimeRobot publishes its monitoring IP ranges at `https://api.uptimerobot.com/meta/ips`; Captcha Protect fetches the list at startup and refreshes it every 24 hours. Unlike SEO crawler bypasses, UptimeRobot also bypasses the challenge when `protectParameters: "true"` and URL parameters are present.

=== "Structured (YAML)"

    ```yaml
    enableUptimeRobotBypass: "true"
    ```

=== "Structured (TOML)"

    ```toml
    enableUptimeRobotBypass = "true"
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableUptimeRobotBypass=true"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableUptimeRobotBypass=true"
    ]
    ```
