This is a plain environment meant for one thing: Build plain static websites with little or no javascript.

The "apache" image is based on OpenSUSE Tumbleweed. Tumbleweed is a "cutting edge" rolling distribution. Think Arch Linux but more mature and user-friendly.

The image created by the "web_build" Dockerfile will create a rather huge image. It is designed to allow you to create websites using the markup language of your choice. You can either use Daps with Asciidoc, Sphinx with reStructuredText, or Pandoc with Markdown.

To log into the container and use the tools, run: `docker -it exec torfiedweb_apache_1`.
To fetch your Tor onion service, run `docker exec torfiedweb_tor_1 v3onions`

The apache container does not have any logs running for apache. This is to keep any visitors safe in case your website is seized or hacked.
