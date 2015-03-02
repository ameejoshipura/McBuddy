RUBY_FILES=$(wildcard **/*.rb)

all: js ruby

js:
	bundle exec jshint
	java -jar build/Google\ CC/compiler.jar --js_output_file=bin/app.js 'develop/js/**.js'

ruby:
	bundle exec ruby-lint $(RUBY_FILES)
	bundle exec rubocop
