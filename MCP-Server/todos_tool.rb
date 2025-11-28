# frozen_string_literal: true

class TodosTool < ApplicationTool
  description 'Manage todos. Actions: list, create, update, delete'

  arguments do
    required(:action).filled(:string, included_in?: %w[list create update delete]).description('Action to perform')
    optional(:id).filled(:integer).description('ID of the todo')
    optional(:title).filled(:string).description('Title for the todo')
    optional(:completed).filled(:bool).description('Set the completion status of the todo')
  end

  def call(action:, **args)
    case action
    when 'list'
      list_todos
    when 'create'
      create_todo(args.fetch(:title))
    when 'update'
      update_todo(args.fetch(:id), args)
    when 'delete'
      delete_todo(args.fetch(:id))
    end
  end

  private

  def list_todos
    Todo.all.map { |todo| "[#{todo.completed ? 'x' : ' '}] ##{todo.id}: #{todo.title}" }.join("\n")
  end

  def create_todo(title)
    todo = Todo.create!(title: title)
    "Created todo ##{todo.id}: #{todo.title}"
  end

  def update_todo(id, attributes)
    todo = Todo.find(id)
    # Only update title and completed status if they are provided
    todo.update!(attributes.slice(:title, :completed))
    "Updated todo ##{todo.id}"
  end

  def delete_todo(id)
    Todo.find(id).destroy!
    "Deleted todo ##{id}"
  end
end
