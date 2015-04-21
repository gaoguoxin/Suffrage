class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  NEWS = 1
  PREV = 2
  REVI = 3
  mount_uploader :image, MaterialUploader
  field :name, type: String
  field :source,type:String
  field :content, type: String
  field :status, type: Integer
  field :type,type:Integer,default:NEWS
  
  def show_type
  	return '热点资讯' if self.type == NEWS
  	return '比赛预告' if self.type == PREV
  	return '精彩回顾' if self.type == REVI
  end
end
