# Shell Server - MCP Server

A simple Model Context Protocol (MCP) server that provides a terminal tool for executing shell commands.

## Features

- **Terminal Tool**: Execute shell/terminal commands remotely
- **Error Handling**: Proper error handling with timeouts
- **Safe Execution**: 30-second timeout to prevent hanging commands
- **Detailed Output**: Returns stdout, stderr, return code, and original command

## Installation

### Option 1: As a uv project (recommended for development)

1. Initialize or add to your existing project:
```bash
# For new projects
uv init mcp-shell-server
cd mcp-shell-server

# Add the MCP dependency
uv add mcp
```

2. Copy the server.py file to your project directory

### Option 2: Install as a tool (recommended for end users)

Install the MCP CLI tool:
```bash
uv tool install mcp
```

Then use the server directly:
```bash
mcp install server.py
```

## Usage

### Development/Testing

Test the server with MCP Inspector:
```bash
# If using uv project
uv run mcp dev server.py

# If using tool installation
mcp dev server.py
```

### Production

Run the server directly:
```bash
# If using uv project
uv run python server.py

# If using tool installation  
python server.py
```

## Tool: terminal_tool

Execute shell commands and get detailed results.

**Parameters:**
- `command` (string): The shell command to execute

**Returns:**
- `stdout`: Standard output from the command
- `stderr`: Standard error from the command  
- `return_code`: Exit code of the command
- `command`: The original command that was executed
- `error`: Error message if command fails or times out

**Example Usage:**
```python
# List directory contents
terminal_tool("ls -la")

# Check Python version
terminal_tool("python --version")

# Run a simple command
terminal_tool("echo 'Hello, World!'")
```

## Safety Features

- Commands timeout after 30 seconds
- Empty commands are rejected
- Errors are properly caught and returned
- All output is captured and returned safely

## Security Note

⚠️ **Warning**: This tool executes arbitrary shell commands. Only use in trusted environments and be careful with the commands you run.
