class Gallery < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :assets
	# limits number of galleries user can have	
	validate :check_galleries_limit, :on => :create
	# ADD AN ON DELETE, CLEAN UP ASSET RELATIONSHIPS

	default_scope -> { order('created_at DESC') }
	
	validates :title, presence: true , length: { in: 3..128 } , codeless:  true #custom validator
	validates :user_id, presence: true

	#validate :galleries_limit#, {:on => :create,  :message => "You have reached your limit"}

	def to_param
    "#{id}-#{title.parameterize}"
  	end

	# Set passed-in order for passed-in ids.
	def order(ids)
		update_attributes(:asset_order => ids.join(','))
	end


	def check_galleries_limit
	  if User.find(self.user_id).reached_galleries_limit?
	    self.errors[:base] << "Cannot add any more Galleries"
	  end
	end



end
