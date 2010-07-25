require 'spec_helper'

describe "todos/edit.html.haml" do
  before(:each) do
    @todo = assign(:todo, stub_model(Todo,
      :new_record? => false,
      :summary => "MyString",
      :detail => "MyString",
      :progress => 1,
      :user => nil
    ))
  end

  it "renders the edit todo form" do
    render

    rendered.should have_selector("form", :action => todo_path(@todo), :method => "post") do |form|
      form.should have_selector("input#todo_summary", :name => "todo[summary]")
      form.should have_selector("input#todo_detail", :name => "todo[detail]")
      form.should have_selector("input#todo_progress", :name => "todo[progress]")
      form.should have_selector("input#todo_user", :name => "todo[user]")
    end
  end
end
