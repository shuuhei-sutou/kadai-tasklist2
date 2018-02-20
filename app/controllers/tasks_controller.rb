class TasksController < ApplicationController
  
  def index
    @task=Task.new
    @tasks = current_user.tasks.order('created_at').page(params[:page])
  end

  def show
    @task=Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      flash[:success] = 'Task が正常に追加されました'
      redirect_to :tasks
    else
      @tasks = current_user.tasks.paginate(:page => params[:page])
      flash.now[:danger] = 'Task が追加されませんでした'
      render :action => 'index'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は追加されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
