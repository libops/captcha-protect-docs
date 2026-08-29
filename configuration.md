# Configuration

## Example

These examples configure the same `captcha-protect` middleware and attach it to an `nginx` router. The protected route starts with `/` by setting `protectRoutes: "/"`.

!!! note
    These are Traefik routing configuration examples. The plugin must also be enabled in Traefik's install configuration:

    ```bash
    --experimental.plugins.captcha-protect.modulename=github.com/libops/captcha-protect
    --experimental.plugins.captcha-protect.version=v1.14.0
    ```

!!! warning "Unsupported v2 tags"
    `v2.0.0`, `v2.0.1`, and `v2.0.2` were withdrawn because Traefik cannot load them. Use `v1.14.0` or a newer v1 release, and do not pin or recreate those v2 tags.

!!! warning
    `secretKey` values in labels or tags may be visible to users who can inspect Docker, ECS, Consul, Nomad, or similar provider metadata. Use structured files or secret-aware deployment tooling when that metadata is not tightly controlled.

!!! note "Breaking changes in v1.14.0"
    `ipv4subnetMask`, `ipv6subnetMask`, and `rateLimit` have been removed. Given the distributed nature of bots, these config values have become additional config and logic that adds no real value. Most crawlers at this point are issuing a small amount of requests per IP across a wide range of subnets.

    `enableStateReconciliation` and all state reconciliation code have been removed. `persistentStateFile` is now restart persistence only, not multi-instance coordination. For multiple protected services, use [multi-layer routing](multiple-services.md) instead of attaching the plugin to every router.

The examples use `window: 864000`. Any non-exempt client IP is immediately challenged on protected routes. Once the client passes a challenge, that IP is not challenged again for 10 days.

=== "Structured (YAML)"

    ```yaml
    http:
      routers:
        nginx:
          entryPoints:
            - http
          rule: "Host(`example.com`)"
          service: nginx
          middlewares:
            - captcha-protect

      services:
        nginx:
          loadBalancer:
            servers:
              - url: "http://nginx:80"

      middlewares:
        captcha-protect:
          plugin:
            captcha-protect:
              window: 864000
              protectRoutes:
                - "/"
              captchaProvider: turnstile
              siteKey: "<TURNSTILE_SITE_KEY>"
              secretKey: "<TURNSTILE_SECRET_KEY>"
              goodBots:
                - apple.com
                - archive.org
                - duckduckgo.com
                - facebook.com
                - instagram.com
                - kagibot.org
                - linkedin.com
                - msn.com
                - openalex.org
                - twitter.com
                - x.com
              persistentStateFile: /tmp/captcha-protect/state.json
              enableCommonCrawlIPCheck: "true"
              enableGooglebotIPCheck: "true"
              enableUptimeRobotBypass: "false"
              periodSeconds: 30
              failureThreshold: 3
    ```

=== "Structured (TOML)"

    ```toml
    [http.routers.nginx]
      entryPoints = ["http"]
      rule = "Host(`example.com`)"
      service = "nginx"
      middlewares = ["captcha-protect"]

    [http.services.nginx.loadBalancer]
      [[http.services.nginx.loadBalancer.servers]]
        url = "http://nginx:80"

    [http.middlewares.captcha-protect.plugin.captcha-protect]
      window = 864000
      protectRoutes = ["/"]
      captchaProvider = "turnstile"
      siteKey = "<TURNSTILE_SITE_KEY>"
      secretKey = "<TURNSTILE_SECRET_KEY>"
      goodBots = [
        "apple.com",
        "archive.org",
        "duckduckgo.com",
        "facebook.com",
        "instagram.com",
        "kagibot.org",
        "linkedin.com",
        "msn.com",
        "openalex.org",
        "twitter.com",
        "x.com",
      ]
      persistentStateFile = "/tmp/captcha-protect/state.json"
      enableCommonCrawlIPCheck = "true"
      enableGooglebotIPCheck = "true"
      enableUptimeRobotBypass = "false"
      periodSeconds = 30
      failureThreshold = 3
    ```

=== "Labels"

    ```yaml
    services:
      nginx:
        image: nginx:${NGINX_TAG}
        labels:
          - "traefik.enable=true"
          - "traefik.http.routers.nginx.entrypoints=http"
          - "traefik.http.routers.nginx.service=nginx"
          - "traefik.http.routers.nginx.rule=Host(`${DOMAIN}`)"
          - "traefik.http.routers.nginx.middlewares=captcha-protect@docker"
          - "traefik.http.services.nginx.loadbalancer.server.port=80"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.window=864000"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectRoutes=/"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.captchaProvider=turnstile"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.siteKey=${TURNSTILE_SITE_KEY}"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.secretKey=${TURNSTILE_SECRET_KEY}"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,duckduckgo.com,facebook.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.persistentStateFile=/tmp/captcha-protect/state.json"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableCommonCrawlIPCheck=true"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableUptimeRobotBypass=false"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.periodSeconds=30"
          - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.failureThreshold=3"
    ```

=== "Tags"

    ```json
    {
      "Name": "nginx",
      "Address": "nginx",
      "Port": 80,
      "Tags": [
        "traefik.enable=true",
        "traefik.http.routers.nginx.entrypoints=http",
        "traefik.http.routers.nginx.service=nginx",
        "traefik.http.routers.nginx.rule=Host(`example.com`)",
        "traefik.http.routers.nginx.middlewares=captcha-protect",
        "traefik.http.services.nginx.loadbalancer.server.port=80",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.window=864000",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.protectRoutes=/",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.captchaProvider=turnstile",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.siteKey=<TURNSTILE_SITE_KEY>",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.secretKey=<TURNSTILE_SECRET_KEY>",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.goodBots=apple.com,archive.org,duckduckgo.com,facebook.com,instagram.com,kagibot.org,linkedin.com,msn.com,openalex.org,twitter.com,x.com",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.persistentStateFile=/tmp/captcha-protect/state.json",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableCommonCrawlIPCheck=true",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableGooglebotIPCheck=true",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableUptimeRobotBypass=false",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.periodSeconds=30",
        "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.failureThreshold=3"
      ]
    }
    ```

## Config Reference

### Required

`protectRoutes`
:   Type: `[]string`; default: `""`; required for `prefix` and `regex` modes.

    Route prefixes, suffixes, or regex patterns to protect. `protectRoutes: "/"` protects the whole site when `mode: prefix`. In `suffix` mode, provide at least one suffix or no routes will be protected.

`captchaProvider`
:   Type: `string`; default: `turnstile`.

    CAPTCHA type to use. Supported values are `turnstile`, `hcaptcha`, `recaptcha`, and `poj` for proof-of-javascript.

`siteKey`
:   Type: `string`; default: `""`; required.

    CAPTCHA site key. For `poj`, use any non-empty placeholder value.

`secretKey`
:   Type: `string`; default: `""`; required.

    CAPTCHA secret key. For `poj`, use any non-empty placeholder value.

### Matching

`mode`
:   Type: `string`; default: `prefix`.

    Must be `prefix`, `suffix`, or `regex`. Matching does not include query parameters. `excludeRoutes` uses prefix matching except when `mode: regex`.

`excludeRoutes`
:   Type: `[]string`; default: `""`.

    Routes to never protect. For example, `protectRoutes: "/"` with `excludeRoutes: "/ajax"` never challenges routes starting with `/ajax`.

`protectParameters`
:   Type: `string`; default: `"false"`.

    Forces challenges for `goodBots`, Google crawler IPs, and Common Crawl IPs when URL parameters are present. This is useful for faceted search and other expensive query combinations. It does not override `enableUptimeRobotBypass`.

`protectFileExtensions`
:   Type: `[]string`; default: `""`.

    File extensions to protect. Protected routes only protect HTML by default, which prevents CSS, JavaScript, images, and similar assets from triggering challenges.

`protectHttpMethods`
:   Type: `[]string`; default: `"GET,HEAD"`.

    HTTP methods to protect.

### Identity And Cache Window

`window`
:   Type: `int`; default: `86400`.

    Duration, in seconds, for retaining verified-client and bot cache entries. Longer windows retain more entries and can increase memory use.

`ipForwardedHeader`
:   Type: `string`; default: `""`.

    Header to check for the original client IP when Traefik is behind a load balancer. Only set this when Traefik receives the header from a trusted proxy or load balancer; otherwise clients can spoof their IP.

`ipDepth`
:   Type: `int`; default: `0`.

    How deep past the last non-exempt IP to fetch the real IP from `ipForwardedHeader`. `0` returns the last non-exempt IP in the forwarded header.

`exemptIps`
:   Type: `[]string`; default: private IP ranges.

    CIDR-formatted IP ranges that should never be challenged. Private IP ranges are always exempt.

`exemptUserAgents`
:   Type: `[]string`; default: `""`.

    Case-insensitive user-agent substrings to never challenge. For example, `YandexBot` exempts user agents containing `YandexBot`.

### SEO

`goodBots`
:   Type: `[]string`; default: `""`.

    Second-level domains for bots that are never challenged unless `protectParameters` applies. See [Good bots](good-bots.md) for a recommended list.

`enableCommonCrawlIPCheck`
:   Type: `string`; default: `"true"`.

    Treat IPs in Common Crawl's published CCBot ranges as good bots. Captcha Protect fetches `https://index.commoncrawl.org/ccbot.json` at startup and refreshes it every 24 hours. Each published IPv4 address must reverse-resolve to `commoncrawl.org` and resolve forward to the same address; addresses that fail verification are omitted. Published IPv6 ranges are loaded as supplied. `protectParameters` still applies.

`enableGooglebotIPCheck`
:   Type: `string`; default: `"false"`.

    Treat IPs in Google's published bot IP ranges as good bots. `protectParameters` still applies.

### Monitoring

`enableUptimeRobotBypass`
:   Type: `string`; default: `"false"`.

    Bypass challenges for IP ranges published by UptimeRobot. The ranges are refreshed every 24 hours. This monitoring bypass also applies when `protectParameters` is `"true"` and the request has URL parameters.

### Challenge Page

`challengeURL`
:   Type: `string`; default: `"/challenge"`.

    URL where challenges are served. This overrides existing routes if there is a conflict. Setting it to blank presents the challenge on the same page that triggered protection.

`challengeTmpl`
:   Type: `string`; default: `"challenge.tmpl.html"`.

    Path to the Go HTML template for the challenge page. If the file is missing, the built-in template is used.

`challengeStatusCode`
:   Type: `int`; default: `200`.

    HTTP response status code for the challenge page. When `challengeURL` is blank, the default is `429`.

### Provider Health

`periodSeconds`
:   Type: `int`; default: `0`.

    Health check interval, in seconds, for the primary CAPTCHA provider. The circuit breaker is disabled unless this and `failureThreshold` are both greater than `0`.

`failureThreshold`
:   Type: `int`; default: `0`.

    Number of consecutive health check failures before the circuit breaker opens and switches to proof-of-javascript fallback.

### Persistence And Observability

`persistentStateFile`
:   Type: `string`; default: `""`.

    File path to persist verified challenge state across Traefik restarts. When unset, no state load/save goroutine is started. Dirty local state is saved about every 60 seconds plus 0-2 seconds of jitter. Derived bot lookup cache entries are not persisted. In Docker, mount this file from the host.

`enableStatsPage`
:   Type: `string`; default: `"false"`.

    Allows `exemptIps` to access `/captcha-protect/stats` for runtime verification state.

`logLevel`
:   Type: `string`; default: `INFO`.

    Middleware log level. Supported values are `ERROR`, `WARNING`, `INFO`, and `DEBUG`.
