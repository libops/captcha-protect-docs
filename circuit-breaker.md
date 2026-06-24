# Circuit Breaker

The circuit breaker provides automatic failover when the primary CAPTCHA provider, such as Turnstile, reCAPTCHA, or hCaptcha, becomes unavailable.

When enabled, it:

1. Enables a liveness probe on the CAPTCHA provider. It periodically sends HEAD requests to the provider's JavaScript file every `periodSeconds` and tracks 5xx errors during server-side validation.
2. Detects failures by counting consecutive health check failures.
3. Opens the circuit after `failureThreshold` consecutive failures, switching to proof-of-javascript fallback.
4. Falls back to PoJ, which ensures the user is loading JavaScript and requires revalidating in one hour.
5. Automatically recovers by returning to the primary provider when health checks succeed.

## Proof-of-javascript fallback

- Requires browsers to submit a form.
- Is self-contained and has no external dependencies.

## Configuration

The circuit breaker is enabled by setting both `periodSeconds` and `failureThreshold`:

=== "Structured (YAML)"

    ```yaml
    periodSeconds: 30
    failureThreshold: 3
    ```

=== "Structured (TOML)"

    ```toml
    periodSeconds = 30
    failureThreshold = 3
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.periodSeconds=30"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.failureThreshold=3"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.periodSeconds=30",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.failureThreshold=3"
    ]
    ```

To disable it, set both `periodSeconds: 0` and `failureThreshold: 0`, which is the default configuration.

The `poj` provider can also be used directly as the primary provider. In that mode, no circuit breaker is needed.
