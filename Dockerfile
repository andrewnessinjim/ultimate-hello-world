FROM  node:17-bullseye-slim as base


ENV PATH=/app/node_modules/.bin:$PATH

#Express port
EXPOSE 3000

#Hack to solve cypress perm error
RUN chmod 777 /root
ENV NODE_ENV=development

WORKDIR /app

COPY package*json ./
RUN npm ci && npm cache clean --force

##################################################################################
##################################################################################

FROM base as dev
WORKDIR /app/sourcecode

#Node debugger port
EXPOSE 9229

CMD ["gulp", "server:dev"]

##################################################################################
##################################################################################

FROM base as prod

COPY . .

RUN gulp server:build 

ENV NODE_ENV=production

#This will clean up non-production dependencies because NODE_ENV is now production (Disabled for now to save build time in circleci)
#RUN npm ci && npm cache clean --force

CMD ["node","/app/run.js"]