doc-server:
	cd docs && bundle update && bundle exec jekyll serve --host=0.0.0.0 --drafts
