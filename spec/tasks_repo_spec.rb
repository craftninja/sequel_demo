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
    tasks = @tasks_repo.all
    expect(tasks).to eq(
      [
        {id: 1, description: description, completed: false}
      ]
    )

  end
end