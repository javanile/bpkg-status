
build:
	@bash build.sh

push: build
	git add .
	git commit -am "Release"
	git push

test-bpkg:
	@bash test/bpkg-install-test.sh

test-ubuntu:
	@act