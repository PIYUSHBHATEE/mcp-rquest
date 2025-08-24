# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy project files needed for installation
COPY pyproject.toml uv.lock README.md ./

# Copy source code
COPY mcp_rquest/ ./mcp_rquest/

# Install Python dependencies
RUN pip install --no-cache-dir uv && \
    uv pip install --system .

# Expose port (if needed for MCP server)
EXPOSE 8000

# Set the entry point
ENTRYPOINT ["python", "-m", "mcp_rquest"]
