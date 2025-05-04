class CreatesProject
  attr_reader :name, :task_string, :project

  def initialize(name:, task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    @project = Project.new(name: name)
  end

  def convert_string_to_tasks
    if task_string.length == 0
      []
    else
      title, size = task_string.split(":")
      size = size && size.to_i > 0 ? size : 1
      [Task.new(title: title, size: size)]
    end
  end
end