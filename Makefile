
#https://docs.docker.com/docker-cloud/builds/push-images/
DOCKER_ID_USER:=northhighland
CONTAINER_NAME:=jupyter-power-container
VERSION:=2
HOME_DIR:=$(HOME)/$(CONTAINER_NAME)-home

build:
	docker build -t $(CONTAINER_NAME):$(VERSION) -t $(CONTAINER_NAME):latest .

$(HOME_DIR):
	mkdir -p $(HOME_DIR)

push: build
	docker tag $(CONTAINER_NAME):latest $(DOCKER_ID_USER)/$(CONTAINER_NAME):latest
	docker push $(DOCKER_ID_USER)/$(CONTAINER_NAME):latest
	docker tag $(CONTAINER_NAME):$(VERSION) $(DOCKER_ID_USER)/$(CONTAINER_NAME):$(VERSION)
	docker push $(DOCKER_ID_USER)/$(CONTAINER_NAME):$(VERSION)


pull:
	docker pull $(DOCKER_ID_USER)/$(CONTAINER_NAME):latest

shell: $(HOME_DIR)
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		-v $(HOME_DIR):/home/poweruser \
		$(CONTAINER_NAME):latest \
		bash

shell-root: $(HOME_DIR)
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-u root \
		$(CONTAINER_NAME):latest \
		bash

		# -v $(HOME_DIR):/home/poweruser \

run: serve

serve: $(HOME_DIR)
	mkdir -p .home
	docker run --rm -it \
	  -v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		-v $(HOME_DIR):/home/poweruser \
		-p 8888:8888 \
		$(CONTAINER_NAME):latest \
		jupyter notebook --ip=0.0.0.0

# Check the files in the git repo
# Useful to be sure nothing has been committed that shouldn't be
checkgitfiles:
	git --no-pager log --pretty=format: --name-only --diff-filter=A | sort -u

build2:
	docker build -t $(CONTAINER_NAME)2:$(VERSION) -t $(CONTAINER_NAME)2:latest -f Dockerfile2 .

shell2:
	docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		-v $(HOME_DIR):/home/poweruser \
		$(CONTAINER_NAME)2:latest \
		bash

serve2:
	mkdir -p .home
	docker run --rm -it \
	  -v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		-v $(HOME_DIR):/home/poweruser \
		-p 8888:8888 \
		$(CONTAINER_NAME)2:latest \
		jupyter notebook --ip=0.0.0.0
