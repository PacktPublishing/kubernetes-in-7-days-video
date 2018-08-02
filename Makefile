.PHONY: parse

help:
	@echo "clean   - remove all build artifacts"
	@echo "parse   - parse configuration"
	@echo "build   - generate docs"
	@echo "package - create a Docker image"
	@echo "run     - run Docker container"
	@echo "rm      - remove Docker container"
	@echo "publish - publish Docker image"
	@echo "install - install Gitbook"
	@echo "plugins - install Gitbook plugins"


clean:
	@echo Removing _book/ 
	@rm -Rf _book/

parse:
	@echo Parsing configuration
	@gitbook parse

build: clean
	@echo Generating docs
	gitbook build

package: build
	@echo Creating Docker image
	@docker build -t desdrury/kube7days .

run:
	@echo Running Docker container
	@if [[ `docker ps -a | grep kube7days` != "" ]]; then docker rm -f kube7days; fi
	@docker run -d --name kube7days -p 8000:80 desdrury/kube7days

rm:
	@echo Removing Docker container
	@docker rm -f kube7days

publish:
	@echo Publishing Docker image
	@docker push desdrury/kube7days