MCP.define("todos") do
  #
  # LIST – alle Todos abrufen
  #
  tool "list", desc: "List all todos" do |_args|
    Todo.all.map do |t|
      {
        id: t.id,
        title: t.title,
        completed: t.completed
      }
    end
  end

  #
  # CREATE – neues Todo erstellen
  #
  tool "create", desc: "Create a new todo" do |args|
    raise ArgumentError, "title is required" if args["title"].to_s.strip.empty?

    todo = Todo.create!(
      title: args["title"],
      completed: args["completed"] || false
    )

    {
      id: todo.id,
      title: todo.title,
      completed: todo.completed
    }
  end

  #
  # TOGGLE – Status umschalten
  #
  tool "toggle", desc: "Toggle completed state" do |args|
    raise ArgumentError, "id is required" unless args["id"]

    todo = Todo.find(args["id"])
    todo.update!(completed: !todo.completed)

    {
      id: todo.id,
      title: todo.title,
      completed: todo.completed
    }
  end
end
