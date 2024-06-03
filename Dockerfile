# Use the base image
FROM pytorchignite/nlp:latest

# Install Python 3.11 and Poetry
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Install Poetry
RUN wget https://install.python-poetry.org -O - | python3 -

# Add Poetry to PATH
ENV PATH="/root/.local/bin:$PATH"

# Copy project files
COPY pyproject.toml poetry.lock* /workspace/

WORKDIR /workspace

# Install project dependencies
RUN poetry install --no-root

# Download NLTK data
RUN poetry run python3 -m nltk.downloader punkt wordnet

# Download GloVe embeddings
RUN mkdir -p /opt/glove && \
    cd /opt/glove && \
    wget http://nlp.stanford.edu/data/glove.6B.zip && \
    unzip glove.6B.zip && \
    rm glove.6B.zip

# Set the working directory
WORKDIR /workspace

# Expose the default port
EXPOSE 8888

# Default command
CMD ["poetry", "run", "python3"]
