class CreatesProject
  attr_reader :name, :project

  def initialize(name:)
    @name = name
  end

  def build
    @project = Project.new(name: name)
  end
end