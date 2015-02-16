RUBY_FILES=$(wildcard **/*.rb)

.PHONY: install,ruby-lint

js:
	./node_modules/jshint/bin/jshint **/*.js

ruby:
	bundle exec ruby-lint $(RUBY_FILES)
	bundle exec rubocop
