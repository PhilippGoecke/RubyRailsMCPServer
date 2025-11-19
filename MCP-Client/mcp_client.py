import asyncio
import os
from langchain_ollama.chat_models import ChatOllama
from mcp_use import MCPAgent, MCPClient

# MCP server config
AUTH_TOKEN="secret-token"
CONFIG = {
  "mcpServers": {
    "http_server": {
      "url": "https://localhost:3000",
      "headers": {
        "Authorization": "Bearer ${AUTH_TOKEN}"
      }
    }
  }
}

async def main():
    client = MCPClient.from_dict(CONFIG)
    llm = ChatOllama(model="qwen3:8b", base_url="http://localhost:11434")

    # LLM Agent of the MCPClient
    agent = MCPAgent(llm=llm, client=client, max_steps=20)

    # Prompt the Agent
    result = await agent.run("Tell me my open Todo's")
    print("\n LLM Reply:", result)

    # Close all MCPClient sessions
    await client.close_all_sessions()

if __name__ == "__main__":
    asyncio.run(main())
