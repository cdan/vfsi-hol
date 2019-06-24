FROM ubuntu

COPY ./code /opt/gowebapp
COPY ./config /opt/gowebapp/config

EXPOSE 80

WORKDIR /opt/gowebapp/
ENTRYPOINT ["/opt/gowebapp/gowebapp"]