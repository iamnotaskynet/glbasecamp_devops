FROM alpine:latest
COPY start.sh start.sh
COPY index.html index.html
EXPOSE 80/tcp
RUN apk add --no-cache bash
RUN chmod +x start.sh 
ENTRYPOINT ["/bin/bash","start.sh"]
