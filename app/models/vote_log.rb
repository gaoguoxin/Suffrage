class VoteLog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :doctor_id, type: String
  field :finger, type: String
  belongs_to :doctor
end