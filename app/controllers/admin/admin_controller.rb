class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :admin_authorize
end
