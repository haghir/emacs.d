TARGETS := helm
TARGETS += async
TARGETS += js2-mode
TARGETS += markdown-mode

.PHONY: prepare
prepare:
	patch -p1 < helm.diff

.PHONY: build $(TARGETS)
build: $(TARGETS)

helm: async

$(TARGETS):
	-$(MAKE) -C $@
