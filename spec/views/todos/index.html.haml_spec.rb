require 'spec_helper'

describe "todos/index.html.haml" do
  before(:each) do
    assign(:todos, [
      stub_model(Todo,
        :summary => "Summary",
        :detail => "Detail",
        :progress => 1,
        :user => nil
      ),
      stub_model(Todo,
        :summary => "Summary",
        :detail => "Detail",
        :progress => 1,
        :user => nil
      )
    ])
  end

  it "renders a list of todos" do
    render
    rendered.should have_selector("tr>td", :content => "Summary".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Detail".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => nil.to_s, :count => 2)
  end
end
