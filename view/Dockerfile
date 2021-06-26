FROM node:12.14.1

ENV VUE_APP_PORT='3000'

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN npm install -g @vue/cli
COPY ./vue-project/package*.json /app/vue-project/
COPY ./vue-project/ /app/vue-project/
RUN npm install

# RUN npm install --save axios

# RUN npm run build
