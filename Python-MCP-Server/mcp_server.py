from fastmcp import FastMCP
from starlette.requests import Request
from starlette.responses import PlainTextResponse
from fastmcp.server.auth.providers.jwt import StaticTokenVerifier

mcp = FastMCP(name="MyTestServer")

@mcp.tool
def greet(name: str) -> str:
    """Greet a user by name."""
    return f"Hello, {name}!"

@mcp.custom_route("/health", methods=["GET"])
async def health_check(request: Request) -> PlainTextResponse:
    return PlainTextResponse("OK")

if __name__ == "__main__":
    verifier = StaticTokenVerifier(
        tokens={
            "secret-token": {
                "client_id": "secret@localhost",
                "scopes": ["read:data"]
            }
        },
        required_scopes=["read:data"]
    )

    mcp.run(transport="http", host="0.0.0.0", port=3000, auth=verifier)
