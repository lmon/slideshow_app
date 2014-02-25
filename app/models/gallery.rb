class Gallery < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	
	validates :title, presence: true
	validates :title, length: { in: 3..128 }

	validates :user_id, presence: true

end
