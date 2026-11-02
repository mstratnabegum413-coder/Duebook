FROM node:22.15.1-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY server.js README.md HowToSetup.md LICENSE-NOTE.md ./
COPY Project ./Project
COPY database ./database
ENV NODE_ENV=production
EXPOSE 3000
CMD ["npm","start"]
