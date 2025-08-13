# 1. Start with a pre-built kitchen that already has Node.js
FROM node:18-alpine

# 2. Choose a specific counter to work on inside the kitchen
WORKDIR /usr/src/app

# 3. Copy our shopping list and recipe into the kitchen
COPY package*.json ./
COPY index.js .

# 4. Tell the head chef to buy all the ingredients from the shopping list
RUN npm install

# 5. The command to start our chef when the restaurant opens
CMD [ "npm", "start" ]