# Requirements

IPS-X DecSecOps Exercise

Run a docker registry on your machine (https://docs.docker.com/registry/deploying/):

`docker run -d -p 5000:5000 --restart=always --name registry registry:2`

Create a simple "Hello World" web app in a language of your choice. Create a docker file, and a script that builds an image and pushes it to the registry. Run the script.

Change your app to print a different message, build another image and push it to the registry.

Make sure tags are different and reflect code changes - there is an easy way to tie image tag with code revision.

Make one more code change and push another tag.

Write another script that queries the docker repo and returns latest image tag.

Document in a README.md file your image tagging scheme.

You can use any scripting language, tagging covention.

As an output we expect a git repo with all of you work contained within.
