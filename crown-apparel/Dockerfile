FROM ubuntu

RUN apt update && apt install -y sudo curl

WORKDIR /crown-apparel

COPY . /crown-apparel/

RUN bash ./nodejs_install.sh

EXPOSE 3000

CMD ["npm", "start"]