FROM ruby:2.3-alpine

ENV SOURCE_DIR /usr/src/app
ENV RESOURCE_DIR /opt/resource

ADD src $SOURCE_DIR

RUN mkdir -p $RESOURCE_DIR

RUN ln -s $SOURCE_DIR/check $RESOURCE_DIR/check && \
    ln -s $SOURCE_DIR/in $RESOURCE_DIR/in && \
    ln -s $SOURCE_DIR/out $RESOURCE_DIR/out

RUN chmod +x $RESOURCE_DIR/check && \
    chmod +x $RESOURCE_DIR/in && \
    chmod +x $RESOURCE_DIR/out
