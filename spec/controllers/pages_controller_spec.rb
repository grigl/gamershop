require 'spec_helper'

describe PagesController do

  it "GET index shoud be successfull" do
    get :index
    response.should be_success
  end

end
