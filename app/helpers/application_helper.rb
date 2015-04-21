module ApplicationHelper
	def current?(cname,str)
		return 'active' if cname.to_s == str.to_s
		return ''
	end
end
