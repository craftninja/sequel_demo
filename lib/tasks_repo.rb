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

  def remove(id)
    @all_tasks.where(:id => id).delete
  end

  def show(id)
    [@all_tasks.to_a[id-1]]
  end
end
