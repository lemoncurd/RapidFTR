class FieldsController < ApplicationController
  def index
    
  end

  def new
    field_type = params[:fieldtype]
    field = Field.new("", field_type)
    render field_type
  end
end
