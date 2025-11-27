MCP.define("todos") do
  tool "list", desc: "List all todos" do |_args|
    Todo.all.map do |t|
      { id: t.id, title: t.title, completed: t.completed }
    end
  end

  tool "create", desc: "Create a new todo" do |args|
    todo = Todo.create!(
      title: args["title"],
      completed: args["completed"] || false
    )
    { id: todo.id, title: todo.title, completed: todo.completed }
  end

  tool "toggle", desc: "Toggle completed state" do |args|
    todo = Todo.find(args["id"])
    todo.update!(completed: !todo.completed)
    { id: todo.id, title: todo.title, completed: todo.completed }
  end
end
