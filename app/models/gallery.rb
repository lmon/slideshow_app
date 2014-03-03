class Gallery < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :assets

	default_scope -> { order('created_at DESC') }
	
	validates :title, presence: true , length: { in: 3..128 } 
	validates :user_id, presence: true


	def to_param
    "#{id}-#{title.parameterize}"
  	end


end
