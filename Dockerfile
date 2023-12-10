FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04 AS base

WORKDIR /app

# Install dependencies
# Install python and pip
RUN apt-get update && apt-get install -y python3 python3-pip && apt-get clean

# COPY current directory to root
COPY . .

RUN pip install -r requirements.txt

ENTRYPOINT python3 src/train.py && \
    python3 src/train.py data=classifier model=classifier callbacks=classifier_train_callback && \
    python3 src/eval.py model=classifier +callbacks=classifier_eval_callback
