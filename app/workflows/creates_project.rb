class CreatesProject
  attr_reader :name, :task_string, :project

  def initialize(name:, task_string: "")
    @name = name
    @task_string = task_string
  end

  def create
    build
    project.tasks = convert_string_to_tasks
    project.save
  end

  def build
    @project = Project.new(name: name)
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |task_substr|
      title, size =  task_substr.split(":")
      size = size && size.to_i > 0 ? size : 1
      Task.new(title: title, size: size)
    end
  end
end