# Troubleshooting

## Verify that your Turnstile site key is configured properly

One reason `captcha-protect` may not work is that the Cloudflare Turnstile widget site key or private key is not properly set for `captcha-protect` to access.

The steps below confirm whether the Turnstile site key is configured correctly.

!!! warning
    There is currently no easy way to check the private key, since the secret key should never be displayed on a webpage or shared.

1. Visit the `captcha-protect` challenge URL, which is set to `https://example.com/challenge` by default.
2. You should see a web page that says `Verifying connection`. If you customized the `challengeTmpl` configuration, the page may say something different.
3. Look at the HTML source code for `https://example.com/challenge`, for example by right-clicking the page in Chrome and selecting "View page source".
4. In the HTML source view, look for a `<div>` tag with an attribute named `data-sitekey`, and check whether its value matches your Cloudflare Turnstile widget site key value.
5. If the site key value does not match, update `docker-compose.yml` and/or your `.env` file to correctly pass the site key value. Also check whether the Cloudflare Turnstile widget secret key is set correctly.

You need to log in to your Cloudflare account and go to the Turnstile section to see your site key and secret key values.
