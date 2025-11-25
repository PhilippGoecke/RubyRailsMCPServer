from fastmcp import FastMCP
from starlette.requests import Request
from starlette.responses import PlainTextResponse
from fastmcp.server.auth.providers.jwt import StaticTokenVerifier

verifier = StaticTokenVerifier(
    tokens={
        "secret-token": {
            "client_id": "secret@localhost",
            "scopes": ["read:data"]
        }
    },
    required_scopes=["read:data"]
)

mcp = FastMCP(name="MyTestServer", auth=verifier)

@mcp.tool
def list_todos() -> list[dict]:
    """Return a list of todo items."""
    return [
        {"id": 1, "title": "Write documentation", "completed": False},
        {"id": 2, "title": "Implement authentication", "completed": True},
        {"id": 3, "title": "Add health check endpoint", "completed": True},
        {"id": 4, "title": "Add Tests", "completed": False},
    ]

@mcp.custom_route("/health", methods=["GET"])
async def health_check(request: Request) -> PlainTextResponse:
    return PlainTextResponse("OK")

if __name__ == "__main__":
    mcp.run(transport="http", host="0.0.0.0", port=3000)
