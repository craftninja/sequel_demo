require 'sequel'

class TasksRepo
  def initialize(db)
    @all_tasks = db[:tasks]
  end

  def create(task)
    @all_tasks.insert(task)
  end

  def all
    @all_tasks.to_a
  end

  def modify(id, updated_task)
    @all_tasks.where(:id => id).update(updated_task)
  end
end