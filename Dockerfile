FROM node
RUN git clone https://github.com/timurb/flatris.git
WORKDIR /flatris
RUN yarn install
RUN yarn build
ENTRYPOINT yarn start
