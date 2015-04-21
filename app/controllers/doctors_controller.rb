class DoctorsController < ApplicationController
	layout 'admin'
	before_filter :require_sign_in
	before_filter :set_doctor,:only => [:edit,:update,:destroy]
	def  index
		@doctors = Doctor.desc(:point).page(params[:page]).per(20)
	end

	def new
		@doctor = Doctor.new 
	end

	def create 
		Doctor.create(doctor_params)
		redirect_to doctors_url
	end

	def edit
	end

	def update
		@doctor.update(doctor_params)
		redirect_to doctors_url
	end

	def destroy
		@doctor.destroy
		redirect_to doctors_url		
	end


  	private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end	

    def doctor_params
      params.require(:doctor).permit(:name,:hospital,:office,:position,:content,:avatar,:point,:title)
    end
end