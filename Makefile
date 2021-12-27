.PHONY: help
.SILENT: help
help:
	echo "make init   : initialize submodules"
	echo "make build  : build submodules"
	echo "make reset  : reset submodules (reset --hard && clean -fdx)"
	echo "make update : reset and update submodules"

.PHONY: init
init:
	git submodule update --init --recursive

.PHONY: build
build:
	$(MAKE) build -C vendor

.PHONY: reset
reset:
	git submodule foreach git reset --hard
	git submodule foreach git clean -fdx
	git submodule update

.PHONY: update
update: reset
	git submodule foreach git pull origin master
