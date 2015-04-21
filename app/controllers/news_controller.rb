class NewsController < ApplicationController
	def index
		params[:type] ||= '1'
		@blogs = Blog.where(type:params[:type].to_i).desc(:created_at)
	end

	def show
		@blog  = Blog.find(params[:id])
	end
end