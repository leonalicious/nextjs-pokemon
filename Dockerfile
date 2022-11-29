# https://docs.docker.com/samples/library/node/
ARG NODE_VERSION=16.14.0

# Build container
FROM node:${NODE_VERSION}-alpine
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Create app directory
RUN mkdir -p /home/node
WORKDIR /home/node

# Install app dependencies
COPY . /home/node

RUN apk --no-cache add --virtual native-deps g++ gcc libgcc libstdc++ linux-headers make python build-base && \
    npm config set unsafe-perm true && \
    npm install --quiet node-gyp -g && \
    apk del native-deps

# If you are building your code for production
# RUN npm ci --only=production

EXPOSE 3000
CMD npm run build && npm run start

