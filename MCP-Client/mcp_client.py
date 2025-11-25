import asyncio
import os
from langchain_ollama.chat_models import ChatOllama
from mcp_use import MCPAgent, MCPClient

# MCP server config
CONFIG = {
  "mcpServers": {
    "http_server": {
      "url": "http://host.containers.internal:3000/mcp",
      "headers": {
        "Authorization": "Bearer secret-token"
      }
    }
  }
}

async def main():
    client = MCPClient.from_dict(CONFIG)
    llm = ChatOllama(
      model="qwen3:8b",
      base_url="http://host.containers.internal:11434",
      headers={"Authorization": "Bearer secret-key"},
    )

    # LLM Agent of the MCPClient
    agent = MCPAgent(llm=llm, client=client, max_steps=20)

    # Prompt the Agent
    result = await agent.run("Tell me all Todo's")
    print("\n LLM Reply:", result)

    # Close all MCPClient sessions
    await client.close_all_sessions()

if __name__ == "__main__":
    asyncio.run(main())
