# Monitoring

If you set `enableStatsPage` to `"true"`, `exemptIps` can access `/captcha-protect/stats` to monitor the rate limiter. The top-level `rate` key lists client IPs that have active rate entries based on request patterns and your `captcha-protect` configuration values.

If you use a computer within `exemptIps` and have the command line tools `curl` and `jq`, this command lists the top 25 IPs by current request count:

```bash
curl -s https://example.com/captcha-protect/stats | jq -r '.rate | to_entries | sort_by(.value.value) | .[] | "\(.key): \(.value.value)"' | tail -25
```

The rate limiter and verified challenge portions of this JSON state data are also found in the `state.json` file configured through the `persistentStateFile` setting and volume definition in your deployment.

Dirty state is saved roughly every 60 seconds plus 0-2 seconds of jitter. If `persistentStateFile` is unset, state persistence is disabled.

Do not manually edit the state file. It should only be changed by `captcha-protect`.
