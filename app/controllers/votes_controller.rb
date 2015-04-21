class VotesController < ApplicationController
	# 用户注册页
	def  index
	end

	# 用户注册动作
	def create
		render_json_auto User.generate(params)
	end

	# 投票类列表页
	def doctors
		@doctors = Doctor.all
	end

	def show
		@doctor = Doctor.find(params[:id])
	end

	def vote
		doc = Doctor.vote(params)
		render_json_auto  doc
	end
end