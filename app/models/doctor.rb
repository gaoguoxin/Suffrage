class Doctor
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :avatar, AvatarUploader

  field :name, type: String
  field :hospital, type: String
  field :office,  type: String
  field :position, type: String
  field :title,type:String
  field :content, type: String # 医生简介
  field :point,type:Integer,default:0
  has_many :vote_logs

  def self.vote(opt)
  	doctor = self.where(id:opt[:id]).first
  	if doctor.present?
  		vote_count = VoteLog.where(finger:opt[:finger]).count
  		if vote_count < 24 # 最多给24个医生投票
  			vg = VoteLog.where(doctor_id:opt[:id],finger:opt[:finger]).first
  			return ErrorEnum::VOTE_EXIST if vg.present?
  			VoteLog.create(doctor_id:opt[:id],finger:opt[:finger])
  			doctor.inc(point:1)
  			return doctor
  		else
  			return ErrorEnum::VOTE_MUCH
  		end
  	end		
  end
end