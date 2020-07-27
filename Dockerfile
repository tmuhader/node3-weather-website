FROM node:14.2.0-alpine
RUN mkdir -p /wheatherApp
WORKDIR /wheatherApp
#this following 2 commands are useless from Dev as the package.json and dependencies files already exist in the host volume mounted into the container
COPY package.json ./
#for development no need to copy the application folders into the image because we are mounting this folder as a host mounted volume
#in the container. but we need to install nodemon but for production we need to still to copy it and not install nodemon to keep the container light.
#and run npm install (With the --production flag, npm will not install modules listed in devDependencies.
#Furthermore, the npm ci command helps provide faster, reliable, reproducible builds for production environments).
#we can create 2 Dockerfiles; one for production (Dockerfile calling: npm start) and one for Dev (Dockerfile_dev calling: npm test)
RUN npm install --production
COPY . .
EXPOSE 3000
ENTRYPOINT ["npm"]
CMD ["start"]