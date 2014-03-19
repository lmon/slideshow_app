class Gallery < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :assets

	default_scope -> { order('created_at DESC') }
	
	validates :title, presence: true , length: { in: 3..128 } , codeless:  true #custom validator
	validates :user_id, presence: true


	def to_param
    "#{id}-#{title.parameterize}"
  	end

	# Set passed-in order for passed-in ids.
	def order(ids)
		update_attributes(:asset_order => ids.join(','))
	end

	def Gallery.per_page
    	10
  	end


end
