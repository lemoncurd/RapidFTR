class HistoriesController < ApplicationController
  
  def show
    @child = Child.get(params[:child_id])
      @histories = @child["histories"]
  end
end