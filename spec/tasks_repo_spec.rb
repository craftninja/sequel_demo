require 'tasks_repo'

describe TasksRepo do

  before do
    db = Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_test')
    db.create_table! :tasks do
      primary_key :id
      String :description
      Boolean :completed, default: false
    end
    @tasks_repo = TasksRepo.new(db)
  end

  it "can create tasks" do
    description = "Do #{rand(2..20)} stuff"
    @tasks_repo.create(description: description)
    actual = @tasks_repo.all
    expected = [{id: 1, description: description, completed: false}]
    expect(actual).to eq(expected)
  end

  it "can update a task" do
    @tasks_repo.create(description: "Get some red silk")
    update = {:description => "Get some red velvet", :completed => true}
    @tasks_repo.modify(1, update)
    actual = @tasks_repo.all
    update[:id] = 1
    expected = [update]
    expect(actual).to eq(expected)
  end

  it "can delete a task" do
    @tasks_repo.create(description: "Get some red velvet")
    @tasks_repo.create(description: "Draft Ruby pattern")
    @tasks_repo.remove(1)
    actual = @tasks_repo.all
    expected = [{:id => 2, :description => "Draft Ruby pattern", :completed => false}]
    expect(actual).to eq(expected)
  end
end
