#!make

build:
	@bash build.sh

push:
	git add .
	git commit -am "Release"
	git push

test-bpkg:
	@bash test/bpkg-install-test.sh

test-ubuntu:
	@act