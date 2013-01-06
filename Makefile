
build :
	npm run-script build

publish : build
	s3cmd sync out s3://paulbutler.org/

serve :
	npm run-script serve

