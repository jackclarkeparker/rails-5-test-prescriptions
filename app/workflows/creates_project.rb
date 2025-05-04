class CreatesProject
  attr_reader :name, :task_string, :project

  def initialize(name:, task_string: "")
    @name = name
    @task_string = task_string
  end

  def create
    build
    project.save
  end
  
  def build
    @project = Project.new(name: name)
    project.tasks = convert_string_to_tasks
    project
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |task_substr|
      title, size_string =  task_substr.split(":")
      Task.new(title: title, size: size_as_integer(size_string))
    end
  end

  def size_as_integer(size_string)
    return 1 if size_string.blank?
    [size_string.to_i, 1].max
  end
end