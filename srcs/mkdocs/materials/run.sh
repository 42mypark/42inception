#!/bin/sh
mkdocs new resume;
mv /materials/mkdocs.yml resume/;
mv /materials/*.md resume/docs/;
cd resume;
mkdocs build;
mkdir -p /wordpress/resume
mv -f /resume/site/* /wordpress/resume/