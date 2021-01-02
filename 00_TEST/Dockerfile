FROM busybox
COPY start.sh start.sh
COPY index.html index.html
EXPOSE 8000
# RUN apk add --no-cache bash
RUN chmod +x start.sh 
ENTRYPOINT ["/bin/sh","start.sh"]
