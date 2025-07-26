FROM nikolaik/python-nodejs:python3.9-nodejs18

# Install ffmpeg + ntpdate for time sync
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ffmpeg ntpdate \
    && ntpdate -s time.nist.gov \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/

RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt

# Before starting bot, sync time again (extra safety)
CMD ntpdate -s time.nist.gov && bash start
