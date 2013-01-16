class QueriesController < ApplicationController
  def new
  end

  def create
    @query = QueryDecorator.decorate(Query.new(params[:query]))
    render 'new'
  end
end
