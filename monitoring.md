# Monitoring

`enableStatsPage` exposes `/captcha-protect/stats` to clients in `exemptIps`. The response includes verified challenge state and approximate cache memory usage.

=== "Structured (YAML)"

    ```yaml
    enableStatsPage: "true"
    exemptIps:
      - "203.0.113.10/32"
    ```

=== "Structured (TOML)"

    ```toml
    enableStatsPage = "true"
    exemptIps = ["203.0.113.10/32"]
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableStatsPage=true"
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.exemptIps=203.0.113.10/32"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.enableStatsPage=true",
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.exemptIps=203.0.113.10/32"
    ]
    ```

If you use a computer within `exemptIps` and have the command line tools `curl` and `jq`, this command lists verified IPs:

```bash
curl -s https://example.com/captcha-protect/stats | jq -r '.verified | keys[]'
```

The verified challenge portion of this JSON state data is also found in the `state.json` file configured through the `persistentStateFile` setting and volume definition in your deployment.

Dirty state is saved roughly every 60 seconds plus 0-2 seconds of jitter. If `persistentStateFile` is unset, state persistence is disabled.

Do not manually edit the state file. It should only be changed by `captcha-protect`.
