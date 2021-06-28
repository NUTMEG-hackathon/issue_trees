FROM node:12.14.1

ENV VUE_APP_PORT='3000'

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN npm install -g @vue/cli
COPY ./package*.json /app/
COPY ./ /app/
RUN npm install

# RUN npm install --save axios

# RUN npm run build
