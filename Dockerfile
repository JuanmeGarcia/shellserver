# Use Python 3.12 slim as base image
FROM python:3.12-slim-bookworm

# Install uv by copying from the official distroless image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Create a non-root user for security
RUN groupadd --gid 1000 app && \
    useradd --uid 1000 --gid app --shell /bin/bash --create-home app

# Copy dependency files first for better layer caching
COPY --chown=app:app pyproject.toml uv.lock ./

# Install dependencies (without the project itself for better caching)
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project

# Copy the source code
COPY --chown=app:app . .

# Install the project in the final sync
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked

# Switch to non-root user
USER app

# Set environment variables for the MCP server
ENV PYTHONUNBUFFERED=1
ENV UV_SYSTEM_PYTHON=0

# Expose port if needed (though MCP typically uses stdio)
EXPOSE 8000

# Health check to verify the server can start
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python -c "import subprocess; subprocess.run(['python', '-c', 'from server import mcp; print(\"Server imports successfully\")'], check=True)"

# Default command to run the MCP server
CMD ["uv", "run", "server.py"]
