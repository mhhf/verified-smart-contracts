# Settings
# --------

specs_dir:=specs
build_dir:=.build

.PHONY: all clean kevm clean-kevm

all: k-files split-proof-tests

clean:
	rm -rf $(specs_dir) $(build_dir)

pandoc_tangle_submodule:=$(build_dir)/pandoc-tangle
TANGLER:=$(pandoc_tangle_submodule)/tangle.lua
LUA_PATH:=$(pandoc_tangle_submodule)/?.lua;;
export LUA_PATH

$(TANGLER):
	git submodule update --init -- $(pandoc_tangle_submodule)

kevm_repo:=https://github.com/kframework/evm-semantics
kevm_repo_dir:=$(build_dir)/evm-semantics

kevm: clean-kevm
	git clone $(kevm_repo) --depth 1 $(kevm_repo_dir)
	cd $(kevm_repo_dir) \
		&& make deps \
		&& make build-java

clean-kevm:
	rm -rf $(kevm_repo_dir)

# Definition Files
# ----------------

k_files:=lemmas.k

k-files: $(patsubst %, $(specs_dir)/%, $(k_files))

# Lemmas
$(specs_dir)/lemmas.k: resources/lemmas.md $(TANGLER)
	@echo >&2 "== tangle: $@"
	mkdir -p $(dir $@)
	pandoc --from markdown --to "$(TANGLER)" --metadata=code:".k" $< > $@

# Spec Files
# ----------

bihu_collectToken_file:=collectToken-spec.k

bihu_forwardToHotWallet_files:=forwardToHotWallet-success-1-spec.k \
                               forwardToHotWallet-success-2-spec.k \
                               forwardToHotWallet-failure-1-spec.k \
                               forwardToHotWallet-failure-2-spec.k \
                               forwardToHotWallet-failure-3-spec.k \
                               forwardToHotWallet-failure-4-spec.k

erc20_files:=totalSupply-spec.k \
             balanceOf-spec.k \
             allowance-spec.k \
             approve-spec.k \
             transfer-success-1-spec.k \
             transfer-success-2-spec.k \
             transfer-failure-1-spec.k \
             transfer-failure-2-spec.k \
             transferFrom-success-1-spec.k \
             transferFrom-success-2-spec.k \
             transferFrom-failure-1-spec.k \
             transferFrom-failure-2-spec.k

zeppelin_erc20_files:=totalSupply-spec.k \
             balanceOf-spec.k \
             allowance-spec.k \
             approve-spec.k \
             transfer-success-1-spec.k \
             transfer-success-2-spec.k \
             transfer-failure-1-a-spec.k \
             transfer-failure-1-b-spec.k \
             transfer-failure-2-spec.k \
             transferFrom-success-1-spec.k \
             transferFrom-success-2-spec.k \
             transferFrom-failure-1-a-spec.k \
             transferFrom-failure-1-b-spec.k \
             transferFrom-failure-2-spec.k

zilliqa_erc20_files:=totalSupply-spec.k \
             balanceOf-spec.k \
             allowance-spec.k \
             approve-success-1-spec.k \
             approve-success-2-spec.k \
             transfer-success-1-spec.k \
             transfer-success-2-spec.k \
             transfer-failure-1-a-spec.k \
             transfer-failure-1-b-spec.k \
             transfer-failure-2-spec.k \
             transferFrom-success-1-spec.k \
             transferFrom-success-2-spec.k \
             transferFrom-failure-1-a-spec.k \
             transferFrom-failure-1-b-spec.k \
             transferFrom-failure-2-spec.k

zrx_erc20_files:=totalSupply-spec.k \
             balanceOf-spec.k \
             allowance-spec.k \
             approve-spec.k \
             transfer-success-spec.k \
             transfer-failure-spec.k \
             transferFrom-success-1-spec.k \
             transferFrom-success-2-spec.k \
             transferFrom-failure-spec.k

hobby_erc20_files:=totalSupply-spec.k \
                   balanceOf-spec.k \
                   allowance-spec.k \
                   approve-success-spec.k \
                   approve-failure-spec.k \
                   transfer-success-1-spec.k \
                   transfer-success-2-spec.k \
                   transfer-failure-1-spec.k \
                   transfer-failure-2-spec.k \
                   transferFrom-success-1-spec.k \
                   transferFrom-success-2-spec.k \
                   transferFrom-failure-1-spec.k \
                   transferFrom-failure-2-spec.k

ds_token_erc20_files:=totalSupply-spec.k \
                   balanceOf-spec.k \
                   allowance-spec.k \
                   approve-success-spec.k \
                   approve-failure-spec.k \
                   transfer-success-1-spec.k \
                   transfer-success-2-spec.k \
                   transfer-failure-1-a-spec.k \
                   transfer-failure-1-b-spec.k \
                   transfer-failure-1-c-spec.k \
                   transfer-failure-2-a-spec.k \
                   transfer-failure-2-b-spec.k \
                   transferFrom-success-1-spec.k \
                   transferFrom-success-2-spec.k \
                   transferFrom-failure-1-a-spec.k \
                   transferFrom-failure-1-b-spec.k \
                   transferFrom-failure-1-c-spec.k \
                   transferFrom-failure-1-d-spec.k \
                   transferFrom-failure-2-a-spec.k \
                   transferFrom-failure-2-b-spec.k \
                   transferFrom-failure-2-c-spec.k

tron_erc20_files:=totalSupply-spec.k \
                   balanceOf-spec.k \
                   allowance-spec.k \
                   approve-success-spec.k \
                   approve-failure-a-spec.k \
                   approve-failure-b-spec.k \
                   approve-failure-c-spec.k \
                   transfer-success-1-spec.k \
                   transfer-success-2-spec.k \
                   transfer-failure-1-a-spec.k \
                   transfer-failure-1-b-spec.k \
                   transfer-failure-1-c-spec.k \
                   transfer-failure-1-d-spec.k \
                   transfer-failure-2-a-spec.k \
                   transfer-failure-2-b-spec.k \
                   transfer-failure-2-c-spec.k \
                   transferFrom-success-1-spec.k \
                   transferFrom-success-2-spec.k \
                   transferFrom-failure-1-a-spec.k \
                   transferFrom-failure-1-b-spec.k \
                   transferFrom-failure-1-c-spec.k \
                   transferFrom-failure-1-d-spec.k \
                   transferFrom-failure-1-e-spec.k \
                   transferFrom-failure-2-a-spec.k \
                   transferFrom-failure-2-b-spec.k \
                   transferFrom-failure-2-c-spec.k \
                   transferFrom-failure-2-d-spec.k


icon_erc20_files:=totalSupply-spec.k \
                   balanceOf-spec.k \
                   allowance-spec.k \
                   approve-success-spec.k \
                   approve-failure-a-spec.k \
                   approve-failure-b-spec.k \
                   approve-failure-c-spec.k \
                   transfer-success-1-spec.k \
                   transfer-success-2-spec.k \
                   transfer-failure-1-a-spec.k \
                   transfer-failure-1-b-spec.k \
                   transfer-failure-1-c-spec.k \
                   transfer-failure-1-d-spec.k \
                   transfer-failure-2-a-spec.k \
                   transfer-failure-2-b-spec.k \
                   transfer-failure-2-c-spec.k \
                   transferFrom-success-1-spec.k \
                   transferFrom-success-2-spec.k \
                   transferFrom-failure-1-a-spec.k \
                   transferFrom-failure-1-b-spec.k \
                   transferFrom-failure-1-c-spec.k \
                   transferFrom-failure-1-d-spec.k \
                   transferFrom-failure-1-e-spec.k \
                   transferFrom-failure-2-a-spec.k \
                   transferFrom-failure-2-b-spec.k \
                   transferFrom-failure-2-c-spec.k \
                   transferFrom-failure-2-d-spec.k

casper_files:=recommended_target_hash-spec.k \
              proc_reward-spec.k \
              vote-spec.k \
              delete_validator-spec.k

general_files:=totalSupply-spec.k \
             balanceOf-spec.k \
             allowance-spec.k \
             approve-spec.k \
             transfer-spec.k \
			 transferFrom-spec.k

proof_tests:= vyper-erc20 zeppelin-erc20 hobby-erc20 ds-token-erc20 tron_erc20 icon_erc20 zrx_erc20 zilliqa_erc20


split-proof-tests: $(proof_tests)

vyper-erc20: $(patsubst %, $(specs_dir)/vyper-erc20/%, $(erc20_files)) $(specs_dir)/lemmas.k

zeppelin-erc20: $(patsubst %, $(specs_dir)/zeppelin-erc20/%, $(zeppelin_erc20_files)) $(specs_dir)/lemmas.k

hobby-erc20: $(patsubst %, $(specs_dir)/hobby-erc20/%, $(hobby_erc20_files)) $(specs_dir)/lemmas.k

ds-token-erc20: $(patsubst %, $(specs_dir)/ds-token-erc20/%, $(ds_token_erc20_files)) $(specs_dir)/lemmas.k

tron_erc20: $(patsubst %, $(specs_dir)/tron_erc20/%, $(tron_erc20_files)) $(specs_dir)/lemmas.k

icon_erc20: $(patsubst %, $(specs_dir)/icon_erc20/%, $(icon_erc20_files)) $(specs_dir)/lemmas.k

zrx_erc20: $(patsubst %, $(specs_dir)/zrx_erc20/%, $(zrx_erc20_files)) $(specs_dir)/lemmas.k

zilliqa_erc20: $(patsubst %, $(specs_dir)/zilliqa_erc20/%, $(zilliqa_erc20_files)) $(specs_dir)/lemmas.k

# ERC20
erc20_tmpls:=erc20/module-tmpl.k erc20/spec-tmpl.k

$(specs_dir)/vyper-erc20/%-spec.k: $(erc20_tmpls) erc20/vyper/vyper-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/zeppelin-erc20/%-spec.k: $(erc20_tmpls) erc20/zeppelin/zeppelin-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/hobby-erc20/%-spec.k: $(erc20_tmpls) erc20/hobby/hobby-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/ds-token-erc20/%-spec.k: erc20/module-tmpl.k erc20/spec-tmpl.k erc20/ds-token/ds-token-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/tron_erc20/%-spec.k: $(erc20_tmpls) erc20/tron/tron-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/icon_erc20/%-spec.k: $(erc20_tmpls) erc20/icon/icon-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/zrx_erc20/%-spec.k: $(erc20_tmpls) erc20/zrx/zrx-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)

$(specs_dir)/zilliqa_erc20/%-spec.k: $(erc20_tmpls) erc20/zilliqa/zilliqa-erc20-spec.ini
	@echo >&2 "==  gen-spec: $@"
	mkdir -p $(dir $@)
	python3 resources/gen-spec.py $^ $* $* > $@
	cp erc20/abstract-semantics.k $(dir $@)
	cp erc20/verification.k $(dir $@)
# Testing
# -------

TEST:=$(kevm_repo_dir)/kevm prove

test_files:=$(wildcard specs/*/*-spec.k)

test: $(test_files:=.test)

specs/%-spec.k.test: specs/%-spec.k
	$(TEST) $<
