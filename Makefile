SOURCE=Dockerfile
IMAGE=latex

FILE = main
OLD = old
NEW = new
DIFF = diff

.PHONY: init
init:
	if [ ! -e src ]; then mkdir src ; fi && \
	mv ${FILE}.zip src && \
	cd src && \
	unzip ${FILE}.zip && \
	rm -rf ${FILE}.zip && \
	cd ..

# build container image
.PHONY: build
build:
	docker image build -f ${SOURCE} -t ${IMAGE} .

# create new container and pdf
.PHONY: run
run:
	docker container run -it --rm \
		-v ${PWD}/src:/work/latex \
		-w /work/latex \
		${IMAGE} \
		sh -c "uplatex ${FILE}.tex && dvipdfmx ${FILE}.dvi"

# create new container and diff.tex
.PHONY: diff
diff:
	docker container run -it --rm \
		-v ${PWD}/src:/work/latex \
		-w /work/latex \
		${IMAGE} \
		sh -c "latexdiff -t CFONT -s COLOR ${OLD}.tex ${NEW}.tex > ${DIFF}.tex"

# clean up all stopped containers
.PHONY: clean
clean:
	docker container prune
