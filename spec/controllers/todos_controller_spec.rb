require 'spec_helper'

describe TodosController do

  def mock_todo(stubs={})
    @mock_todo ||= mock_model(Todo, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all todos as @todos" do
      Todo.stub(:all) { [mock_todo] }
      get :index
      assigns(:todos).should eq([mock_todo])
    end
  end

  describe "GET show" do
    it "assigns the requested todo as @todo" do
      Todo.stub(:find).with("37") { mock_todo }
      get :show, :id => "37"
      assigns(:todo).should be(mock_todo)
    end
  end

  describe "GET new" do
    it "assigns a new todo as @todo" do
      Todo.stub(:new) { mock_todo }
      get :new
      assigns(:todo).should be(mock_todo)
    end
  end

  describe "GET edit" do
    it "assigns the requested todo as @todo" do
      Todo.stub(:find).with("37") { mock_todo }
      get :edit, :id => "37"
      assigns(:todo).should be(mock_todo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created todo as @todo" do
        Todo.stub(:new).with({'these' => 'params'}) { mock_todo(:save => true) }
        post :create, :todo => {'these' => 'params'}
        assigns(:todo).should be(mock_todo)
      end

      it "redirects to the created todo" do
        Todo.stub(:new) { mock_todo(:save => true) }
        post :create, :todo => {}
        response.should redirect_to(todo_url(mock_todo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved todo as @todo" do
        Todo.stub(:new).with({'these' => 'params'}) { mock_todo(:save => false) }
        post :create, :todo => {'these' => 'params'}
        assigns(:todo).should be(mock_todo)
      end

      it "re-renders the 'new' template" do
        Todo.stub(:new) { mock_todo(:save => false) }
        post :create, :todo => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested todo" do
        Todo.should_receive(:find).with("37") { mock_todo }
        mock_todo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :todo => {'these' => 'params'}
      end

      it "assigns the requested todo as @todo" do
        Todo.stub(:find) { mock_todo(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:todo).should be(mock_todo)
      end

      it "redirects to the todo" do
        Todo.stub(:find) { mock_todo(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(todo_url(mock_todo))
      end
    end

    describe "with invalid params" do
      it "assigns the todo as @todo" do
        Todo.stub(:find) { mock_todo(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:todo).should be(mock_todo)
      end

      it "re-renders the 'edit' template" do
        Todo.stub(:find) { mock_todo(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested todo" do
      Todo.should_receive(:find).with("37") { mock_todo }
      mock_todo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the todos list" do
      Todo.stub(:find) { mock_todo }
      delete :destroy, :id => "1"
      response.should redirect_to(todos_url)
    end
  end

end
