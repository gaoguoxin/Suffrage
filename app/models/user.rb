class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :province, type: String
  field :city, type: String
  field :area, type: String
  field :company,  type: String
  field :position, type: String
  field :mobile, type: String
  field :email, type: String
  field :content, type: String

  def self.generate(opt)
  	user = self.where(mobile:opt[:mobile]).first
  	return ErrorEnum::USER_EXIST if user.present?
  	return self.create(name:opt[:name],province:opt[:province],city:opt[:city],area:opt[:area],company:opt[:company],position:opt[:position],mobile:opt[:mobile],content:opt[:content])
  end
end
