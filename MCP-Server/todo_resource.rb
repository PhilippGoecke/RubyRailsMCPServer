# frozen_string_literal: true

class TodoResource < ApplicationResource
  uri 'todos'
  resource_name 'Todos'
  description 'A todo resource'
  mime_type 'application/json'

  def content
    JSON.generate(Todo.all.as_json)
  end
end
