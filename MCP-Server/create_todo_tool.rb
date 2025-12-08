# frozen_string_literal: true

class CreateTodoTool < ApplicationTool
  description <<~DESC
    This tool allows you to create or update a todo.
    You can specify the title and whether the todo is done.
    If you don't specify a title, it will return an error.
    If you don't specify whether the todo is done when creating, it will default to false.
    Before creating a todo, check if a todo with the same title already exists.
    If the todo is created successfully, it will return the created todo with its attributes.
    If the todo is updated successfully, it will return the updated todo with its attributes.
    If there is an error, it will return an error message.
    Expected request format for create:
    {
      "title": "implement Rails MCP Server",
      "completed": false
    }
    Expected request format for update:
    {
      "id": 1,
      "title": "implement Rails MCP Server",
      "completed": true
    }
    Expected response format:
    {
      "id": 1,
      "title": "implement Rails MCP Server",
      "completed": false,
      "created_at": "2025-11-28T12:00:00Z",
      "updated_at": "2025-11-28T12:00:00Z"
    }
  DESC

  arguments do
    required(:title).filled(:string).description('Title of the todo')
    optional(:id).maybe(:integer).description('The id of the todo, used for updating')
    optional(:completed).maybe(:bool).description('Whether the todo is done, defaults to false if not provided')
  end

  def call(title:, id: nil, completed: false)
    todo = Todo.find_by(id: id) if id

    if todo
      todo.update(completed: completed, title: title)
      {
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
        created_at: todo.created_at.iso8601,
        updated_at: todo.updated_at.iso8601
      }
      Rails.logger.info("Todo '#{todo.id}' updated.")
    else
      todo = Todo.create!(title: title, completed: completed)
      {
        id: todo.id,
        title: todo.title,
        completed: todo.completed,
        created_at: todo.created_at.iso8601,
        updated_at: todo.updated_at.iso8601
      }
      Rails.logger.info("Todo '#{todo.id}' created.")
    end
  rescue StandardError => e
    { error: e.message }
  end
end
