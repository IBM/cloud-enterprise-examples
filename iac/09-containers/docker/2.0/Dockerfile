FROM python:3.7-slim AS build

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential gcc && \
  pip install --upgrade pip && \
  pip install pip-tools
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY app.py .
COPY import.py .
COPY requirements.txt requirements.in
RUN pip-compile requirements.in > requirements.txt && \
  pip-sync && \
  pip install -r requirements.txt

FROM python:3.7-slim AS app
COPY --from=build /opt/venv /opt/venv

COPY app.py .
COPY import.py .
RUN chmod +x app.py import.py

ENV PATH="/opt/venv/bin:$PATH"

CMD [ "python", "app.py" ]
