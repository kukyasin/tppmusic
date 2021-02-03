FROM node:12.19-slim

ENV USER=tppmusic

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create tppmusic user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/tppmusic -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/tppmusic

COPY package*.json ./
RUN npm install
VOLUME [ "/home/tppmusic" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
