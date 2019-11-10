This is a plain environment meant for one thing: Build plain static websites with little or no javascript.

The "apache" image is based on [OpenSUSE Tumbleweed](https://en.opensuse.org/Portal:Tumbleweed). Tumbleweed is a "cutting edge" rolling distribution. Think Arch Linux but more mature and user-friendly.

The image created by the "web_build" Dockerfile will create a rather huge image. It is designed to allow you to create websites using the markup language of your choice. You can either use Daps with Asciidoc, Sphinx with reStructuredText, or Pandoc with Markdown.

To log into the container and use the tools, run: `docker exec -it  torfiedweb_apache_1 bash`.

To fetch your Tor onion service url, run `docker exec torfiedweb_tor_1 v3onions`

The apache container does not have any logs running for apache. This is to keep any visitors safe in case your website is seized or hacked.

What is [Tor](https://2019.www.torproject.org/about/overview.html.en)?

For more information on [Daps](https://opensuse.github.io/daps/doc/daps-asciidoc.html) and [Asciidoc](http://asciidoc.org/).

For more information on [Sphinx](https://www.sphinx-doc.org/en/master/) and [reStructuredText](http://docutils.sourceforge.net/rst.html).

For more information on [Pandoc](https://pandoc.org/) and [Markdown](https://www.markdownguide.org/)
