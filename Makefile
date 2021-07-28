SHELL := /bin/bash
PROJECT = websocket_client

include erlang.mk

test-deps:
	mkdir -p test-deps
	git clone https://github.com/extend/cowboy.git test-deps/cowboy
	pushd test-deps/cowboy; git checkout 2.9.0; rebar3 get-deps && rebar3 compile; popd

test: test-deps all
	mkdir -p .ct_results
	ct_run -pa test-deps/cowboy/ebin test-deps/cowboy/deps/*/ebin ebin \
	-dir ct \
	-logdir ./.ct_results \
	-cover ct/websocket_client.coverspec

clear-test:
	rm -rf .ct_results && \
	rm ebin/* && \
	rm -rf deps/* && \
	rm ct/*.beam

.PHONY: test test-deps clear-test
