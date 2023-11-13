FROM python:3.10

# core metadata about this image
LABEL description="A simple Web service which acts as a bridge between the Prometheus Operator's ServiceMonitor objects, and external sites which normally can't be represented by a ServiceMonitor object."
LABEL version="1.0"
LABEL maintainer="Roger Howard <rogerhoward@mac.com>"

ENV PYTHONUNBUFFERED 1

ENV PROMDATE_ROOT="/opt/promdate"

RUN adduser --uid 1313 --home ${PROMDATE_ROOT} taskmaster

RUN pip install --upgrade pip && pip install pipenv

# copy src to working dir
COPY --chown=promdate:promdate ./app/ ${PROMDATE_ROOT}

# set working directory to app install
WORKDIR ${PROMDATE_ROOT}

# install promdate dependencies globally via pipenv
RUN pipenv install --deploy --system

USER promdate

CMD ["gunicorn", "--chdir", "/opt/promdate", "--bind", "0.0.0.0:5000", "--workers", "8",  "promdate:app"]