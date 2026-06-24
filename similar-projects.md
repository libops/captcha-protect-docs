# Similar Projects

- [Traefik RateLimit middleware](https://doc.traefik.io/traefik/middlewares/http/ratelimit/) starts sending `429` responses when traffic exceeds a threshold. Captcha Protect serves a challenge instead, and can exclude static assets from protection.
- [crowdsec-bouncer-traefik-plugin](https://github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin) has a CAPTCHA option, but requires integrating with CrowdSec to verify individual IPs. Captcha Protect checks traffic actually visiting your site and verifies traffic with a challenge on protected routes.
