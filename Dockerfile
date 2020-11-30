FROM alpine:3

MAINTAINER alex <alexwhen@gmail.com> 

#RUN mkdir -p /run/nginx

RUN apk --update add nginx

COPY 2048 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
