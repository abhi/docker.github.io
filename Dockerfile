FROM bagel/universe:dc9b2190001e9c64d7b5e63dbf9999b2e4c83d25

# Source
COPY ./app /opt/hub/app
# Webpack
COPY ./webpack.config.js /opt/hub/webpack.config.js
COPY ./_webpack /opt/hub/_webpack
# Make
COPY ./Makefile /opt/hub/Makefile
# Gulp
COPY ./gulpfile.js /opt/hub/gulpfile.js
COPY ./gulp-tasks /opt/hub/gulp-tasks
# ESLint
COPY ./.eslintrc /opt/hub/.eslintrc
# Flow
ENV LOGNAME bagels
COPY ./flow-libs /opt/hub/flow-libs
COPY .flowconfig /opt/hub/.flowconfig
ENV PATH /opt/flow/:$PATH

RUN DEBUG=* webpack -d
RUN make server-target
RUN make styles-base
RUN gulp images::dev
RUN make images
RUN make docker-font-dev
# favicon
COPY ./app/favicon.ico /opt/hub/app/.build/
