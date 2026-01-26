FROM debian

WORKDIR /root
RUN apt update && apt install -y git make nodejs npm ruby
RUN gem install asciidoctor-pdf rouge
RUN git clone https://github.com/hakimel/reveal.js.git
RUN cd reveal.js && npm install
RUN mkdir /data

WORKDIR /root/reveal.js
ENTRYPOINT npm start -- --host=0.0.0.0
