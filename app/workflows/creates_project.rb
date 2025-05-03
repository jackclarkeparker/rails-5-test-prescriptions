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
      [Task.new(title: task_string, size: 1)]
    end
  end
end