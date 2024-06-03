# nlp-docker-2024

This builds a docker image for use in NLP research as of 2024

pyproject.toml controls the versions of python and various compatible libraries

Github Actions will build the docker image and deploy to Docker Hub 

We should be able to run this 
<code>
docker pull yourdockerhubusername/my-docker-project:latest
docker run -it yourdockerhubusername/my-docker-project:latest
</code>