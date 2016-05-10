class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	validates :contentm, :presence=>{:message => "내용을 반드시 입력"}
end
