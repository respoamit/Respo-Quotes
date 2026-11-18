FROM python:3.12-alpine

WORKDIR /app

RUN pip install --no-cache-dir flask

COPY api/app.py .
COPY app/data/quotes.json .

EXPOSE 5000

CMD ["python", "app.py"]