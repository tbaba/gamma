require 'spec_helper'

describe "todos/show.html.haml" do
  before(:each) do
    @todo = assign(:todo, stub_model(Todo,
      :summary => "Summary",
      :detail => "Detail",
      :progress => 1,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Summary".to_s)
    rendered.should contain("Detail".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(nil.to_s)
  end
end
