class TasksController < ApplicationController
   layout false
   def index
      @tasks = Task.order('created_at DESC') # instance variable: @tasks, available in the view "tasks#index"
      @task = Task.new # for the form

      @task_all = Task.count
      @task_completed = get_completed

      respond_to do |format|
         format.html # <- to render the HTML !!
         format.json { # <- to render the json from fetch
            render json: { task_completed: get_completed } 
         }
    end
   end

   def create
      @task = Task.create(task_params) # get the form_data with
      @task.save
      # return unless @task.save
      
      redirect_to tasks_path unless @task.save
      ActionCable.server.broadcast('tasks_channel', {})
   end

   def complete
      @task = Task.find(params[:id])
      @task.update(completed: true)
      ActionCable.server.broadcast('tasks_channel', {})
   end
  
   private
   def task_params
      params.require(:task).permit(:title)
   end


   def get_completed
      Task.where({completed: true}).count
   end

end