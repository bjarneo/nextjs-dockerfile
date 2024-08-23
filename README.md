## Recommendation
Follow the docker image setup provided by the official docs: https://nextjs.org/docs/app/building-your-application/deploying#docker-image. Remember to add this for the standalone version: https://nextjs.org/docs/app/api-reference/next-config-js/output#automatically-copying-traced-files

# Next.js Dockerfile
Copy the `Dockerfile` to the root of your project.

## Note
This dockerfile is generic and would work for most of the next.js applications out there.

## Build and run locally
```bash
docker build -t <docker_image_name> .

docker run -it -p 3000:3000 --rm --name <container_name> <docker_image_name>

# Need to inject .env file?
# Add this to the run command:
# -v /host/path/.env:/app/.env
docker run -it -p 3000:3000 -v /host/path/.env:/app/.env --rm --name <container_name> <docker_image_name>
```

## Improvements
Most likely the file can be improved even more. Feel free to add a PR.
