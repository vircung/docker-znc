.PHONY: build
build:
	docker build --no-cache=true -t ${USER}/znc .

.PHONY: run
run:
	docker run --restart=always -d -p 29492:6667 --name znc -v ${HOME}/.znc:/znc-data ${USER}/znc

.PHONY: debug
debug:
	docker run -it -p 29492:6667 --name znc-debug -v ${HOME}/.znc:/znc-data ${USER}/znc
