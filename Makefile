
build:
	docker build -t powercontainer:1 .

shell:
	docker run --rm -it \
	  -v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		powercontainer:1 \
		bash

serve:
	mkdir -p .home
	docker run --rm -it \
	  -v /var/run/docker.sock:/var/run/docker.sock \
		--group-add 50 \
		-v $(CURDIR)/.home:/home/poweruser \
		-p 8888:8888 \
		powercontainer:1 \
		jupyter notebook --ip=0.0.0.0
