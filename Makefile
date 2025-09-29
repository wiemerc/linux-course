.PHONY: all build-container start-container stop-container install html pdf zip clean

all: html pdf

build-container:
	docker build -t pdf-builder .

start-container:
	docker run -d --name pdf-builder --rm -v $$PWD:/data -p8000:8000 pdf-builder

stop-container:
	docker kill pdf-builder

# We use the last version of @asciidoctor/reveal.js that still uses reveal.js 3 because they changed the directory
# layout in version 4 and asciidoctor is still not compatible with the new structure.
install:
	npm install asciidoctor @asciidoctor/reveal.js@4.1.0

svg:
	for f in images/*.pdf; do pdftocairo -svg $$f images/$$(basename $$f .pdf).svg; done

# TODO: Add SVG images generated from PDF images to dependencies
html: linux-power-users.html

pdf: linux-power-users.pdf uebungen.pdf

zip: pdf
	zip -r linux-power-users-`date +%Y%m%d` linux-power-users.pdf uebungen.pdf scripts/

usb: html
	cp -r images scripts linux-power-users.adoc linux-power-users.html uebungen.adoc /Volumes/CONSTI/Kurse/linux-power-users/

clean:
	rm -f *.html *.pdf

%.svg: %.pdf
	pdftocairo -svg $^ $@

%.html: %.adoc
	npx asciidoctor-revealjs $^

%.pdf: %.adoc
	docker exec pdf-builder asciidoctor-pdf -a pdf-page-size=A4 -a pdf-page-layout=landscape -a pdf-theme=default-sans -a source-highlighter=rouge /data/$^

linux-power-users.pdf: linux-power-users.html
	docker exec pdf-builder cp /data/$^ /root/reveal.js/index.html
	docker exec pdf-builder cp -r /data/images /root/reveal.js/
	open http://localhost:8000/?print-pdf
