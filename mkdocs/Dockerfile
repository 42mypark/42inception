FROM alpine:3.16
ENV MKDOCS_VERSION=1.3.0
RUN apk add python3 python3-dev py3-pip &&\
	pip install mkdocs==${MKDOCS_VERSION} &&\
	mkdocs new resume &&\
	cd resume
EXPOSE 8000
ENTRYPOINT [ "/bin/sh" ]
