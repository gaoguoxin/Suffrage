class Admin
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :password,type:String

  def self.login(opt)
    pwd  = Secure.encrypt(opt[:password].downcase)
    acc  = opt[:email].downcase.strip
    adm  = self.where(email:acc,password:pwd).first
    return ErrorEnum::USER_NOT_EXIST  unless adm.present?
    return adm
  end

  def self.regist(opt)
    account = opt[:email].downcase.strip
    admin   = self.where(email:account).first
    return ErrorEnum::USER_EXIST if admin.present?
    return self.create({email:account,password:Secure.encrypt(opt[:password].downcase.strip)})
  end  

end
