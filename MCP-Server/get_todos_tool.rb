# frozen_string_literal: true

class GetTodosTool < ApplicationTool
  description <<~DESC
    This tool retrieves all todos.
    It's useful for retriving a list of todos.
    The response will include the todos and their attributes.
    The todos are ordered by creation date, with the most recent first.
    If there are no todos, it will return an empty array.
    With this tool you can get the ID of each todo for further operations like updating or deleting.

    Expected response format:
    [
      {
        "id": 1,
        "title": "Write documentation",
        "done": false,
        "created_at": "2025-11-28T12:00:00Z",
        "updated_at": "2025-11-28T12:00:00Z"
      },
      {
        "id": 2,
        "title": "Implement MCP Server",
        "done": true,
        "created_at": "2025-11-28T12:00:00Z",
        "updated_at": "2025-11-28T12:00:00Z"
      },
      {
        "id": 3,
        "title": "Add Integration Tests",
        "done": false,
        "created_at": "2025-11-28T12:00:00Z",
        "updated_at": "2025-11-28T12:00:00Z"
      }
    ]
  DESC

  def call
    todos = Todo.order(created_at: :desc)

    todos.map do |todo|
      {
        id: todo.id,
        title: todo.title,
        done: todo.completed,
        created_at: todo.created_at.iso8601,
        updated_at: todo.updated_at.iso8601
      }
    end
  rescue StandardError => e
    { error: e.message }
  end
end
