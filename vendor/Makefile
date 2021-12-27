TARGETS := helm
TARGETS += async
TARGETS += js2-mode
TARGETS += markdown-mode

.PHONY: build $(TARGETS)
build: $(TARGETS)

$(TARGETS):
	-$(MAKE) -e -C $@

helm: async
helm: export ASYNC_STRAIGHT_DIR := $(HOME)/.emacs.d/vendor/async
