
build :
	npm run-script build

publish : build
	cd out; s3cmd sync ./ s3://paulbutler.org/

serve :
	npm run-script serve

