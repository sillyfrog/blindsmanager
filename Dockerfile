FROM python

RUN pip install --upgrade pip && \
    pip install paho-mqtt

WORKDIR /app/
COPY blindmanager /app/
COPY config.json /app/
ENV  PYTHONUNBUFFERED=1
CMD ["/app/blindmanager"]
