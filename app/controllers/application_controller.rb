require 'csv'
class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_global_categories

  def set_global_categories
    @categorys = CSV.read(Rails.root.join('db', 'category.csv')).flatten
  end
end
