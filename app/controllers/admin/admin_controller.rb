class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :authorize
end
