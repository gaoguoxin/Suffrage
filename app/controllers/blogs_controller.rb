class BlogsController < ApplicationController
	layout 'admin'
	before_filter :require_sign_in
	before_filter :set_blog,:only => [:edit,:update,:destroy]
	def  index
		@blogs = Blog.desc(:created).page(params[:page]).per(20)
	end

	def new 
		@blog = Blog.new
	end

	def create 
		blog = Blog.new(blog_params)
		if blog.save
			Rails.logger.info '----------保存成功-----------------------------'
		else
			Rails.logger.info blog_params.inspect
			Rails.logger.info '=============================================='
		end
		redirect_to blogs_url
	end

	def edit
	end

	def update	
		@blog.update(blog_params)
		redirect_to blogs_url
	end

	def destroy
		@blog.destroy
		redirect_to blogs_url		
	end


  	private

    def set_blog
      @blog = Blog.find(params[:id])
    end	

    def blog_params
      params.require(:blog).permit(:name,:image,:content,:status,:type,:source)
    end

end