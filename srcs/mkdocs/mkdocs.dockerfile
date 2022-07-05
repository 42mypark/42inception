FROM alpine:3.16
ENV MKDOCS_VERSION=1.3.0
RUN apk add python3 python3-dev py3-pip &&\
	pip install mkdocs==${MKDOCS_VERSION} &&\
	mkdocs new resume
WORKDIR /resume
RUN mkdocs build
COPY ./mkdocs.yml /resume/
EXPOSE 8000
ENTRYPOINT [ "/usr/bin/mkdocs", "serve", "-a", "0.0.0.0:8000" ]
