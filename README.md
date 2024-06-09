# nlp-docker-2024

This builds a docker image for use in NLP research as of 2024

pyproject.toml controls the versions of python and various compatible libraries

Github Actions will build the docker image and deploy to Docker Hub 

We should be able to run this 

## To recreate requirement.txt

poetry export -f requirements.txt --output requirements.txt --without-hashes

<code>
docker pull lampofsocrates/nlp-slim-2024:latest
docker run -it lampofsocrates/nlp-slim-2024:latest
</code>
