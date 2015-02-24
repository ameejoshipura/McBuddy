RUBY_FILES=$(wildcard **/*.rb)

.PHONY: install,ruby-lint

all: js ruby

js:
	./node_modules/jshint/bin/jshint develop/js/**.js
	java -jar build/Google\ CC/compiler.jar --js_output_file=bin/app.js 'develop/js/**.js'

ruby:
	bundle exec ruby-lint $(RUBY_FILES)
	bundle exec rubocop
