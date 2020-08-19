# library/python:2-alpine
FROM library/python@sha256:724d0540eb56ffaa6dd770aa13c3bc7dfc829dec561d87cb36b2f5b9ff8a760a

RUN apk --update add bash
RUN pip install flake8

WORKDIR /usr/local/src/stacker_blueprints
COPY . .

