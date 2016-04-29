
build :
	npm run-script build

publish :
	gsutil rsync -R out gs://www.paulbutler.org
	gsutil acl ch -u AllUsers:R -R gs://www.paulbutler.org

serve :
	npm run-script serve

