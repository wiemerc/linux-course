.PHONY: all build-container start-container stop-container install html preview pdf zip translate clean

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

html: linux-power-users.html

pdf: linux-power-users.pdf uebungen.pdf

zip: pdf
	zip -r linux-power-users-`date +%Y%m%d` linux-power-users.pdf uebungen.pdf scripts/

usb: html
	cp -r images scripts linux-power-users.adoc linux-power-users.html uebungen.adoc /Volumes/CONSTI/Kurse/linux-power-users/

# Run this target only once and rename `linux-power-users.en.adoc` to `linux-power-users.adoc` once you're satisfied with the
# translation (in a separate branch).
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

linux-power-users.pdf: linux-power-users.html
	podman exec pdf-builder cp /data/$^ /root/reveal.js/index.html
	podman exec pdf-builder cp -r /data/images /root/reveal.js/
#	open http://localhost:8000/?print-pdf
