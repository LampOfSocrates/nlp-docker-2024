# Use the base image
#FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel
FROM ubuntu:20.04

# Install Python 3.11 and necessary build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    wget \
    build-essential \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Check disk usage after installation
RUN df -h && du -h --max-depth=1 / | sort -hr | head -n 20

# Install Poetry (version 1.8.3)
RUN curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.8.3 python3 -

# Add Poetry to PATH
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /workspace

# Copy project files
COPY pyproject.toml poetry.lock* /workspace/

# Install project dependencies
RUN poetry install --no-root --no-dev --no-interaction --no-ansi \
    && poetry cache clear --all pypi \
    && rm -rf /root/.cache/pypoetry
# Clean up Poetry cache
RUN poetry cache clear --all pypi && rm -rf /root/.cache/pypoetry

# Additional debugging step: Check Poetry and Python versions
RUN poetry --version && python3 --version
