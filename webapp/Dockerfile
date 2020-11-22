from python:3.9-slim
ADD ./requirements.txt /
RUN pip install -r /requirements.txt
COPY ./app /app
CMD ["python", "/app/main.py", "-p" ,"8000"]
