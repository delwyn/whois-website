class QueriesController < ApplicationController
  def new
  end

  def create
    @query = Query.new(params[:query])
    render 'new'
  end
end
