all: bundle run

run:
	bundle exec ruby main.rb

bundle:
	bundle install