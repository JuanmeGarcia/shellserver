# Shell Server - MCP Server

A simple Model Context Protocol (MCP) server that provides a terminal tool for executing shell commands.

## Features

- **Terminal Tool**: Execute shell/terminal commands remotely
- **Error Handling**: Proper error handling with timeouts
- **Safe Execution**: 30-second timeout to prevent hanging commands
- **Detailed Output**: Returns stdout, stderr, return code, and original command

## Installation

1. Install dependencies:
```bash
pip install mcp[cli]
```

2. Install the server:
```bash
mcp install server.py
```

## Usage

### Development/Testing

Test the server with MCP Inspector:
```bash
mcp dev server.py
```

### Production

Run the server directly:
```bash
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
