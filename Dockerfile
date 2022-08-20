FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev
WORKDIR /app
COPY . /app
RUN pip3 install -r requirements.txt
EXPOSE 5001
ENTRYPOINT ["python3"]
CMD ["main.py"]