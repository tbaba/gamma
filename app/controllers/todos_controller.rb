class TodosController < ApplicationController
  respond_to :json, :html
  before_filter :authenticate_user!

  # GET /todos
  def index
    unless user_signed_in?
      redirect_to new_user_session_url
    else
      @todos = current_user.todos.all
      @todo = current_user.todos.build
    end
  end

  # GET /todos/1
  def show
    @todo = current_user.todos.find params[:id]
  end

  # GET /todos/new
  def new
    @todo = current_user.todos.new
  end

  # GET /todos/1/edit
  def edit
    @todo = current_user.todos.find params[:id]
  end

  # POST /todos
  def create
    @todo = current_user.todos.new params[:todo]

    if @todo.save
      redirect_to @todo, :notice => 'current_user.todo was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /todos/1
  def update
    @todo = current_user.todo.find params[:id]

    if @todo.update_attributes params[:todo]
      redirect_to @todo, :notice => 'Todo was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /todos/1
  def destroy
    @todo = current_user.todo.find params[:id]
    @todo.destroy

    redirect_to todos_url
    end
end
