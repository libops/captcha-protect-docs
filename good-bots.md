# SEO And Monitoring Bypasses

Captcha Protect can bypass known crawlers and monitoring services before a challenge is served. Keep SEO crawler bypasses separate from monitoring bypasses so each setting has an obvious purpose.

## SEO

Use `goodBots` for search, social, archive, and research crawlers that should be allowed to crawl protected routes. Use `enableGooglebotIPCheck` when you want Google's published crawler IP ranges to be treated as good bots.

If you set `protectParameters: "true"`, good bots are still challenged when a URL parameter is present, such as `/search?field=value`. This protects faceted search pages and other expensive query combinations.

=== "Structured (YAML)"

    ```yaml
    goodBots:
      - apple.com
      - archive.org
      - commoncrawl.org
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
    enableGooglebotIPCheck: "true"
    protectParameters: "false"
    ```

=== "Structured (TOML)"

    ```toml
    goodBots = [
      "apple.com",
      "archive.org",
      "commoncrawl.org",
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
    enableGooglebotIPCheck = "true"
    protectParameters = "false"
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,commoncrawl.org,duckduckgo.com,facebook.com,google.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectParameters=false"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,commoncrawl.org,duckduckgo.com,facebook.com,google.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectParameters=false"
    ]
    ```

## Monitoring

Use `enableUptimeRobotBypass` when UptimeRobot should reach protected routes without a challenge. UptimeRobot publishes its monitoring IP ranges at `https://api.uptimerobot.com/meta/ips`; Captcha Protect fetches the list at startup and refreshes it every 24 hours.

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
