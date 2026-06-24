# Regex Matching

When possible, keep regex disabled. Prefix and suffix matching are much cheaper and are enough for most route protection rules.

When needed, regex matching can be enabled with:

=== "Structured (YAML)"

    ```yaml
    mode: regex
    ```

=== "Structured (TOML)"

    ```toml
    mode = "regex"
    ```

=== "Labels"

    ```yaml
    labels:
      - "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.mode=regex"
    ```

=== "Tags"

    ```json
    [
      "traefik.http.middlewares.captcha-protect.plugin.captcha-protect.mode=regex"
    ]
    ```

The benchmark below illustrates the difference between a simple prefix check and a compiled regex match:

```bash
go mod init bench
cat << EOF > bench_test.go
package main

import (
	"regexp"
	"strings"
	"testing"
)

var (
	testPath = "/api/v1/user/profile"
	prefix   = "/api/v1"
	regex    = regexp.MustCompile("^/api/v1")
)

func BenchmarkHasPrefix(b *testing.B) {
	for i := 0; i < b.N; i++ {
		_ = strings.HasPrefix(testPath, prefix)
	}
}

func BenchmarkRegexMatch(b *testing.B) {
	for i := 0; i < b.N; i++ {
		_ = regex.MatchString(testPath)
	}
}
EOF
go test -bench=. -benchmem
```

Example output:

```text
goos: darwin
goarch: amd64
cpu: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
BenchmarkHasPrefix-12     	340856451	         3.415 ns/op	       0 B/op	       0 allocs/op
BenchmarkRegexMatch-12    	27992568	        41.20 ns/op	       0 B/op	       0 allocs/op
PASS
```
