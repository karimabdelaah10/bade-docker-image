# Base Docker Image

This repository contains the Dockerfile and scripts required to build the PhpLaravel starter Docker image.  
This base image is designed to provide a foundation for building a laravel application.

- [Hub URL](https://hub.docker.com/r/ouredu20/base)

### Building the Base Image

1. Create a git tag locally

```
git tag -a {tagNum} -m "Release {tagNum}"
```

2. Push the tag to remote repository

```
git push origin {tagNum}
```

GitHub Actions will automatically detect the tag push event and execute the workflow to build and tag the Docker image then push it to Docker hub
