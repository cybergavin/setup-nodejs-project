.PHONY: npm yarn pnpm all clean

all: npm yarn pnpm

npm:
	mkdir -p test-projects/npm
	cd test-projects/npm && npm init -y && npm install axios

yarn:
	mkdir -p test-projects/yarn
	cd test-projects/yarn && yarn init -y && yarn add axios

pnpm:
	mkdir -p test-projects/pnpm
	cd test-projects/pnpm && pnpm init -y && pnpm add axios

clean:
	rm -rf test-projects