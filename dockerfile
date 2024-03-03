FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y gnupg2
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y python3.10
RUN update-alternatives --install /usr/bin/python3 python /usr/bin/python3.10 1

RUN apt-get update
RUN apt-get -y install libgl1-mesa-glx

RUN apt-get install -y git
RUN git clone "https://github.com/studiolanes/vision-utils"
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN echo "export PATH=$HOME/.local/bin:$PATH" >> ~/.bashrc

ENV PATH="${PATH}:/root/.local/bin"

RUN /bin/bash -c "source ~/.bashrc"

WORKDIR ./vision-utils/spatialconverter
RUN poetry install
RUN poetry run pip install -q git+https://github.com/huggingface/transformers.git

WORKDIR ./spatialconverter

# ENTRYPOINT ["/bin/bash", "-c", "poetry shell"]

# TODO: - Use poetry run and env to just create images
