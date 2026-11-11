.PHONY: all build-container start-container stop-container install html preview pdf zip translate clean

LANG ?= de

all: html pdf

build-container:
	podman build -t pdf-builder .

start-container:
	podman run -d --name pdf-builder --rm -v $$PWD:/data -p8000:8000 pdf-builder

stop-container:
	podman kill pdf-builder

# We use the last version of @asciidoctor/reveal.js that still uses reveal.js 3 because they changed the directory
# layout in version 4 and asciidoctor is still not compatible with the new structure.
install:
	npm install asciidoctor @asciidoctor/reveal.js@4.1.0
	python3 -m venv .venv
	.venv/bin/pip install polib deepl

html: linux-power-users.$(LANG).html

pdf: linux-power-users.$(LANG).pdf

zip: pdf
	zip -r linux-power-users-`date +%Y%m%d` linux-power-users.$(LANG).pdf scripts/

usb: html
	cp -r images/*.$(LANG).* scripts linux-power-users.$(LANG).adoc linux-power-users.$(LANG).html /Volumes/CONSTI/Kurse/linux-power-users/

# Run this target only once to do the initial translation with DeepL
translate:
	po4a po4a.cfg
	cp po/linux-power-users.pot po/linux-power-users.en.po
	sed -i 's/^"Language: .*/"Language: en\\n"/' po/linux-power-users.en.po
	.venv/bin/python3 ./scripts/translate-po.py po/linux-power-users.en.po
	po4a po4a.cfg

clean:
	rm -f *.html *.pdf

%.html: %.adoc
	npx asciidoctor-revealjs $^

%.pdf: %.adoc
	podman exec pdf-builder asciidoctor-pdf -a pdf-page-size=A4 -a pdf-page-layout=landscape -a pdf-theme=default-sans -a source-highlighter=rouge /data/$^

linux-power-users.$(LANG).pdf: linux-power-users.$(LANG).html
	podman exec pdf-builder cp /data/$^ /root/reveal.js/index.html
	podman exec pdf-builder cp -r /data/images /root/reveal.js/
#	xdg-open http://localhost:8000/?print-pdf
