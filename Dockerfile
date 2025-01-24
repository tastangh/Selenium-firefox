FROM python:3.7-alpine3.15

ENV DEPS="\
  dbus \
  ttf-freefont \
  xvfb \
  firefox-esr \
  bash \
  mesa-dri-gallium \
  mesa-egl \
"

RUN pip install robotframework
RUN pip install robotframework-requests
RUN pip install --upgrade robotframework-seleniumlibrary
RUN pip install --upgrade setuptools

# Firefox-esr'yi güncelleyin veya Firefox'u kurun
RUN apk update && \
    apk add --no-cache ${DEPS} && \
    apk add --no-cache --upgrade firefox-esr  # veya apk add --no-cache --upgrade firefox

# xvfb-run'ı kur
RUN apk update && apk add --no-cache xvfb-run

# Install geckodriver
RUN echo "Downloading geckodriver..." && \
    wget -q https://github.com/mozilla/geckodriver/releases/download/v0.35.0/geckodriver-v0.35.0-linux64.tar.gz && \
    echo "Extracting geckodriver..." && \
    tar -C /usr/bin/ -xf geckodriver-*.tar.gz && \
    echo "geckodriver install successful"

# List packages and python modules installed
RUN apk info -vv | sort && \
    pip freeze

# Cleanup
RUN rm -rf /var/cache/apk/* /tmp/requirements.txt /geckodriver-*.tar.gz

RUN mkdir -p /src/example-test-dir/web
WORKDIR /src/example-test-dir/web
RUN ls -l
COPY example-test-dir/web .
RUN ls -l
RUN rm -rf /tmp/.X99-lock

EXPOSE 8082
RUN chmod +x  /src/example-test-dir/web/run_integration_web_tests.sh
CMD ["/src/example-test-dir/web/run_example_tests.sh"]