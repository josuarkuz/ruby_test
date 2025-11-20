class TasksController < ApplicationController
  before_action :set_project, only: [:index, :create]
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    render json: @project.tasks
  end

  def show
    render json: @task
  end

  def create
    task = @project.tasks.new(task_params)

    if params[:assignee_id].present?
      assignee = User.find_by(id: params[:assignee_id])
      task.assignee = assignee if assignee
    end

    task.status ||= "pending"

    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if params[:assignee_id].present?
      assignee = User.find_by(id: params[:assignee_id])
      @task.assignee = assignee
    end

    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
