import asyncio
import os
from langchain_ollama.chat_models import ChatOllama
from mcp_use import MCPAgent, MCPClient

SECRET_TOKEN = os.getenv("MCP_SECRET_TOKEN", "secret-token")
MCP_SERVER = os.getenv("MCP_SERVER", "http://host.containers.internal:3000/mcp/sse")

CONFIG = {
  "mcpServers": {
    "http_server": {
      "url": MCP_SERVER,
      "headers": {
        "Authorization": f"Bearer {SECRET_TOKEN}"
      }
    }
  }
}

async def main():
    client = MCPClient.from_dict(CONFIG)
    OLLAMA_API_KEY = os.getenv("OLLAMA_API_KEY", "secret-key")
    OLLAMA_HOST = os.getenv("OLLAMA_HOST", "http://host.containers.internal:11434")
    MODEL = os.getenv("OLLAMA_MODEL", "qwen3:8b")
    llm = ChatOllama(
      model=MODEL,
      base_url=OLLAMA_HOST,
      headers={"Authorization": f"Bearer {OLLAMA_API_KEY}"},
    )

    # LLM Agent of the MCPClient
    agent = MCPAgent(llm=llm, client=client, max_steps=20)

    # Prompt the Agent
    result = await agent.run("Tell me all Todo's.")
    print("\n LLM Reply:", result)
    result = await agent.run("Add MCP Server Setup to my tasks.")
    print("\n LLM Reply:", result)

    # Close all MCPClient sessions
    await client.close_all_sessions()

if __name__ == "__main__":
    asyncio.run(main())
