module Secure
	require 'digest'
	def self.encrypt(txt)
		return Digest::SHA2.hexdigest txt
	end
end