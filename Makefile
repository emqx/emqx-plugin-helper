REBAR = $(CURDIR)/rebar3
SCRIPTS = $(CURDIR)/scripts

.PHONY: all
all: compile

.PHONY: compile
compile: $(REBAR)
	$(REBAR) compile

$(REBAR):
	@$(SCRIPTS)/ensure-rebar3.sh

.PHONY: distclean
distclean: clean
	@rm -rf _build

.PHONY: fmt
fmt: $(REBAR)
	find . \( -name '*.app.src' -o \
				-name '*.erl' -o \
				-name 'rebar.config' -o \
				-name '*.eterm' -o \
				-name '*.escript' \) \
				-not -path '*/_build/*' \
				-not -path '*/deps/*' \
				-not -path '*/_checkouts/*' \
				-not -path '*/include/*' \
				-type f \
		| xargs $(REBAR) fmt -w --verbose --

# bump-version-patch/minor/major
.PHONY: bump-version
bump-version:
	./scripts/bumpversion.sh $(VERSION)

.PHONY: vendor-emqx-headers
vendor-emqx-headers:
	./scripts/vendor-emqx-headers.sh $(EMQX_TAG)

