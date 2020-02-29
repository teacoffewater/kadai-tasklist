class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only:[:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
    @tasks = current_user.Tasks.order(:id)
    else
     redirect_to login_path
    end
  end

  def show
    @tasks = current_user.Tasks.order(id: :desc)
  end

  def new
    if logged_in?
    @task = current_user.Tasks.build
    end
  end

  def create
  @task = current_user.Tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end

private

  def correct_user
    @task = current_user.Tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:status,:content,)
  end

end