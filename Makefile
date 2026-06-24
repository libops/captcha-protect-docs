.PHONY: help docs-docker-build docs-build docs-serve docs-preview docs-clean

DOCS_IMAGE ?= captcha-protect-docs
DOCS_PORT ?= 8888
DOCS_DOCKER_USER ?= $(shell id -u):$(shell id -g)

help: ## Show documented Make targets
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

docs-docker-build: ## Build the Zensical docs image
	docker build -f Dockerfile -t $(DOCS_IMAGE) .

docs-build: docs-docker-build ## Build the static docs site into ./site
	rm -rf site
	docker run --rm \
		-u "$(DOCS_DOCKER_USER)" \
		$(if $(SITE_URL),-e SITE_URL=$(SITE_URL)) \
		-v "$(CURDIR):/work" \
		-w /work \
		$(DOCS_IMAGE) \
		build --clean --config-file mkdocs.yml

docs-serve: docs-docker-build ## Serve docs with live reload at http://localhost:8888
	docker run --rm -it \
		-u "$(DOCS_DOCKER_USER)" \
		-p $(DOCS_PORT):8080 \
		-v "$(CURDIR):/work" \
		-w /work \
		$(DOCS_IMAGE) \
		serve --config-file mkdocs.yml --dev-addr 0.0.0.0:8080

docs-preview: ## Build docs and serve ./site at http://localhost:8888
	$(MAKE) docs-build SITE_URL=http://localhost:$(DOCS_PORT)
	docker run --rm -it \
		-p $(DOCS_PORT):8080 \
		-v "$(CURDIR)/site:/site" \
		-w /site \
		--entrypoint python3 \
		$(DOCS_IMAGE) \
		-m http.server 8080

docs-clean: ## Remove the generated docs site
	rm -rf site
