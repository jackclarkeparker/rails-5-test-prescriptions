require "rails_helper"

# RSpec.describe CreatesProject do
#   describe "initialization" do
#     it "creates a project given a name" do
#       creator = CreatesProject.new(name: "Project Runway")
#       creator.build
#       expect(creator.project.name).to eq("Project Runway")
#     end
#   end

#   describe "task string parsing" do
#     it "handles an empty string" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks).to be_empty
#     end

#     it "handles a single string" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(1)
#       expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
#     end

#     it "handles a single string with a size" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:3")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(1)
#       expect(tasks.first).to have_attributes(title: "Start Things", size: 3)
#     end
    
#     it "handles a single string with size zero" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:0")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(1)
#       expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
#     end

#     it "handles a single string with malformed size" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(1)
#       expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
#     end

#     it "handles a single string with negative size" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:-3")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(1)
#       expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
#     end

#     it "handles multiple tasks" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
#       tasks = creator.convert_string_to_tasks
#       expect(tasks.size).to eq(2)
#       expect(tasks).to match([
#         an_object_having_attributes(title: "Start Things", size: 3),
#         an_object_having_attributes(title: "End Things", size: 2)
#       ])
#     end
    
#     it "attaches tasks to the project" do
#       creator = CreatesProject.new(name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
#       creator.create
#       expect(creator.project.tasks.size).to eq(2)
#       expect(creator.project).not_to be_a_new_record
#     end
#   end
# end

RSpec.describe CreatesProject do
  let(:creator) { CreatesProject.new(name: name, task_string: task_string) }
  let(:name) { "Project Runway" }
  let(:task_string) { "Roll out the red carpet:1" }

  describe "initialization" do
    let(:task_string) { "" }

    it "creates a project given a name" do
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe "task string parsing" do
    let(:tasks) { creator.convert_string_to_tasks }

    describe "with an empty string" do
      let(:task_string) { "" }
      specify { expect(tasks).to be_empty }
    end

    describe "with a single string" do
      let(:task_string) { "Start Things" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "with a single string with size" do
      let(:task_string) { "Start Things:3" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 3) }
    end

    describe "with a single string with size 0" do
      let(:task_string) { "Start Things:0" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "with a single string with malformed size" do
      let(:task_string) { "Start Things:" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "with a single string with negative size" do
      let(:task_string) { "Start Things:-3" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(title: "Start Things", size: 1) }
    end

    describe "with multiple tasks" do
      let(:task_string) {"Start Things:3\nEnd Things:2"}
      specify { expect(tasks.size).to eq(2) }
      specify do
        expect(tasks).to match([
          an_object_having_attributes(title: "Start Things", size: 3),
          an_object_having_attributes(title: "End Things", size: 2)
        ])
      end
    end

    describe "attaches tasks to the project" do
      let(:task_string) {"Start Things:3\nEnd Things:2"}
      before { creator.create }
      specify { expect(creator.project.tasks.size).to eq(2) }
      specify { expect(creator.project).not_to be_a_new_record }
    end
  end

  describe "failure cases" do
    describe "when given no name" do
      let(:name) { "" }
      before { creator.create }
      specify { expect(creator).not_to be_a_success }
    end
  end
end








