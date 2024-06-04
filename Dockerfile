# Use a smaller base image
FROM python:3.10.14-slim as base

# Install dependencies and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN wget https://install.python-poetry.org -O - | python3 -

# Add Poetry to PATH
ENV PATH="/root/.local/bin:$PATH"

# Create working directory
WORKDIR /workspace

# Copy project files
COPY pyproject.toml poetry.lock* ./

# Install project dependencies
RUN poetry install --no-root --no-dev --no-interaction --no-ansi \
    && poetry cache clear --all pypi \
    && rm -rf /root/.cache/pypoetry


# Expose the default port
EXPOSE 8888

# Default command
CMD ["poetry", "run", "python"]
