#Split everything the build into two steps
FROM node:alpine as builder
# Above, we set the base image for this first stage as a light weigh node called alpine

WORKDIR '/app'
# Above we set the build environment as a folder called /app in the docker container to prevent clashes

COPY package.json .
# To prevent repeated npm installs anytime we make any change, we'd copy over the package.json and install things first

RUN npm install
COPY . .
# Copy the rest of the project over to the /app folder in the container
RUN npm run build
# Build the production version of our app in the container

FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html