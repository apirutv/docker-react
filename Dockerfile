# 1ST STEP
# specify a base image
# the alpine (minimal version) of Node.js
# official image
FROM node:alpine as builder

# specify the working directory
# any following command will be executed
# relative to this path in the container
WORKDIR /usr/react-app-frontend

# copy what needed by 'npm install'
# to container directory
COPY ./package.json ./

# install some dependencies
RUN npm install

# copy all file from current working directory
# to container directory
COPY ./ ./

# build it
RUN npm run build

# 2ND STEP
# second block can only have
# sigle from statement
FROM nginx
EXPOSE 80

# copy content from the previous phase
# the target folder is as specified by nginx documentation
# on docker hub
COPY --from=builder /usr/react-app-frontend/build /usr/share/nginx/html


