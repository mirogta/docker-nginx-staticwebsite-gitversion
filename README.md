# Dockerized static website using NGINX and GitVersion

## What

This is a simple demonstration of creating a simple Docker image, pushing to a local Docker registry and updating the image tags/versions using GitVersion.

## Requirements

See [requirements](doc\requirements.md)

Assumption - since it's supposed to be a web app, rather than returning just the "Hello World" plain text, the web app will return a well-formed HTML document which contains the "Hello World" text. The app is a Single Paged Application (SPA) for simplicity and the language of choice is a simple HTML. This is a very simple scenario which doesn't require any complex or multi-staged builds in the Dockerfile.

NOTE: Developing on a Windows machine, so using *Chocolatey* as a dev package manager rather than *brew*, and using *cmd* scripts rather than `Makefile` with `sh` scripts. The scripts are so simple that there's no need to use PowerShell, however they could be rewritten to PowerShell Core and the solution then would be working on both Windows and Unix-based systems.

## Pre-Requisites

* Windows machine
* Install Chocolatey
* Install Docker: `choco install docker-cli docker-for-windows -y`
* NOTE: On Windows, the default Docker for Windows installation uses Linux containers, but can be switched to use Windows containers. If you've installed Docker for Windows earlier, please ensure your configuration is using Linux containers.
* Install PowerShell Core: `choco install powershell-core -y`
* Install GitVersion: `choco install GitVersion.Portable -y`
* Start a local Docker registry - using the supplied script
    `docker run -d -p 5000:5000 --restart=always --name registry registry:2`

NOTE: After installing Chocolatey, all further dependencies can be installed in one go with:

`choco install docker-cli docker-for-windows powershell-core GitVersion.Portable -y`

## How

> Create a simple "Hello World" web app in a language of your choice. Create a docker file, and a script that builds an image and pushes it to the registry. Run the script.

* Initialised git repo with `git init`
* Created `README.md` and checked it in as an initial commit.
* Created `website\index.html`
* Created the `Dockerfile`
  * Using `nginx:alpine` base image, which will take care of running the web server
  * Adding the website content to the default nginx path
* Created `GitVersion.yml` using `gitversion init`
  * Using *Mainline* mode to automatically update the *patch* version
  * If necessary, the *major* and *minor* version can be bumped up in the `GitVersion.yml` but for the sake of this exercise,
    since the required changes are trivial, `gitversion` will only increment the *patch* version with each commit.
  * For simplicity and since we don't use CI/CD for this example, we won't include a *build* number, which would be auto-generated and provided by a CI/CD tool.
* Created `cmd\build.ps1`
  * This uses the *GitVersion* to determine the image version and is based on commits.
  * For the sake of simplicity the image name is determined by the directory into which the repository is checked out, i.e. typically the repository name itself.
  * Using `docker build` to build the image.
  * The image is tagged just with the version, so that it can be easily tested locally before it's pushed to a Docker registry.
* Executed `cmd\build.ps1`
  * This builds a local image.
* Quick test of the local image:
  ```
  docker images
  docker run -d -p 80:80 <image_name>:<version>
  curl localhost:80
  docker ps
  docker stop <container_id>
  ```
* Committed this change
  * NOTE: Since we're using GitVersion which depends on commits, we need to commit a change in order to get an updated version. This would be typically handled automatically via CI/CD, because images would't be pushed to the a Docker registry manually. This also means that if you make changes locally without committing them, the version number won't increase - for the sake of simplicity it's OK for this exercise.

> Change your app to print a different message, build another image and push it to the registry.

* Updated the message in `website\index.html`
* Created `bin\publish.ps1`, refactored common functions to `bin\functions.ps1`, tested it and committed the changes
  
> Make sure tags are different and reflect code changes - there is an easy way to tie image tag with code revision.

* NOTE: We could rely on e.g. manually-updated `version` file specifying the *major* and *minor* versions and generating the *patch* version based on count of commits... but again for the sake of simplicity for this exercise I went with using the GitVersion so that I don't need to worry about this.

> Make one more code change and push another tag.

* Updated the message in `website\index.html` and committed the change again
* Re-ran `bin\build.ps1` and `bin\publish.ps1`

> Write another script that queries the docker repo and returns latest image tag.

* Created `bin\get-latestversion.ps1`
* Assumption - not using the `:latest` tag as that would be too trivial.

> Document in a README.md file your image tagging scheme.

* The *tagging scheme* is documented in `bin\functions.ps1`. Briefly, it's:
  * `<vendor>/<project>/<application>:<major>.<minor>.<patch>`

> You can use any scripting language, tagging covention.

* Used PowerShell, since it's developed on a Windows machine. But using PowerShell Core, which makes this solution portable.

> As an output we expect a git repo with all of you work contained within.

