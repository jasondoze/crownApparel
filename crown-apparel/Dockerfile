FROM ubuntu

RUN apt update && apt install -y sudo

WORKDIR /crown-apparel

COPY ./* ./

RUN bash multipass_install.sh

RUN bash nginx_install.sh

EXPOSE 3000

EXPOSE 80 

CMD ["nginx", "-g", "daemon off;"]