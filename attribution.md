# Attribution

- The original implementation of this logic was [a Drupal module called turnstile_protect](https://www.drupal.org/project/turnstile_protect). This Traefik plugin was made to make the challenge logic more performant than that Drupal module, and to provide bot protection to non-Drupal websites.
- The general CAPTCHA structs that support multiple providers were based on work in [crowdsec-bouncer-traefik-plugin](https://github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin).
- In-memory cache support is provided by [go-cache](https://github.com/patrickmn/go-cache).
