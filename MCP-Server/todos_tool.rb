module Mcp
  class TodosTool < FastMcp::Tool
    name 'todos'
    description 'Todo Verwaltung'

    parameter :id, type: :integer, required: false
    parameter :title, type: :string, required: false
    parameter :completed, type: :boolean, required: false

    action :list do
      Todo.all.map { |t| { id: t.id, title: t.title, completed: t.completed } }
    end

    action :create do
      t = Todo.create!(title: title, completed: completed || false)
      { id: t.id, title: t.title, completed: t.completed }
    end

    action :toggle do
      t = Todo.find(id)
      t.update!(completed: !t.completed)
      { id: t.id, title: t.title, completed: t.completed }
    end
  end
end
