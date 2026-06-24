# Similar Projects

- [Traefik RateLimit middleware](https://doc.traefik.io/traefik/middlewares/http/ratelimit/) starts sending `429` responses when traffic exceeds a threshold. Captcha Protect can exclude static assets from rate-limit counting and verify traffic with a challenge instead.
- [crowdsec-bouncer-traefik-plugin](https://github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin) has a CAPTCHA option, but requires integrating with CrowdSec to verify individual IPs. Captcha Protect checks traffic actually visiting your site and verifies traffic is from a person only when traffic exceeds the configured rate limit.
