FROM ubuntu

RUN apt update && apt install -y sudo curl

WORKDIR /crown-apparel

COPY . /crown-apparel/

RUN bash ./nodejs_install.sh

RUN bash ./nginx_install.sh

EXPOSE 3000

EXPOSE 80 

# CMD ["npm", "start"]

CMD ["nginx", "-g", "daemon off;"]