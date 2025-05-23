require "rails_helper"

RSpec.describe Project do
  it_should_behave_like "sizeable"

  describe "initialization" do
    let(:project) { Project.new }

    it "properly handles a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining).to be_nan
      expect(project).not_to be_on_schedule
    end
  end


  describe "completion" do
    let(:project) { Project.new }
    let(:task) { Task.new }

    it "considers a project with no tasks to be done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is not done" do
      project.tasks << task
      expect(project).not_to be_done
    end

    it "marks a project done if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe "estimates" do
    # 
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end
    # 

    it "can calculate size" do
      expect(project.size).to eq(10)
    end

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end

    # 
    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7) 
    end

    it "knows its projected days remaining" do
      expect(project.projected_days_remaining).to eq(35) 
    end

    it "knows if it is not on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
    end

    it "knows if it is on schedule" do
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end
    # 
  end

end
