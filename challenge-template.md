# Challenge Template

You probably want to theme the CAPTCHA challenge page to match the style of your site.

Copy the default [`challenge.tmpl.html`](https://github.com/libops/captcha-protect/blob/main/challenge.tmpl.html) file into your Docker Compose project, then mount it into your Traefik container:

```yaml
    traefik:
        volumes:
            - ./host/path/to/challenge.tmpl.html:/challenge.tmpl.html:ro
```

Point the middleware to your overridden template:

```yaml
            traefik.http.middlewares.captcha-protect.plugin.captcha-protect.challengeTmpl: "/challenge.tmpl.html"
```

When you override the challenge template, the process usually looks like this:

1. Copy an HTML file from your existing site so the challenge looks like the rest of your site.
2. Replace some `<div>` in the HTML body with the `<form>...</form><script>...</script>` HTML tags and contents from the default [`challenge.tmpl.html`](https://github.com/libops/captcha-protect/blob/main/challenge.tmpl.html). You must copy the `form` and `script` tags exactly as they are in the original challenge template. They use Go's templating language to inject the proper site key and other variables into the HTML response when a challenge is presented.
3. Make sure this script tag is present in the `<head>` of your overridden template:

```html
<script src="{{ .FrontendJS }}" async defer referrerpolicy="no-referrer"></script>
```
