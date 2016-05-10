class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	validates :username, :presence=>{:message=>"ID를 반드시 입력하시오"}
	validates :username, :uniqueness=>{:message=>"이미존재하는ID", :case_sensitive=>false}
	validates :password, :length=>{:minimum=>6, :too_short=>"최소 6자 이상"}
end
