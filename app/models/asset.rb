class Asset < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries
  validate :check_assets_limit, :on => :create


  default_scope -> { order('created_at DESC') }

  has_attached_file :image, {
    :styles => {
      :thumb => ["75x75#", :png],
      :medium => ["250x250#", :png],
      :large => ["600x600>", :png]
    },
    :convert_options => {
      :thumb => "-gravity Center -crop 50x50+0+0",
      :thumb => "-gravity Center -crop 100x100+0+0",
    },
    :default_url => "/assets/missing.png"
  } 

  validates :user_id, :presence => true

  validates :name, presence: true, length: { in: 3..64 }, codeless: true #custom validator

	validates :caption, length: { maximum: 512  }, codeless: true #custom validator

	validates_attachment :image, :size => { :in => 0..4.megabytes , :message => "must be less than 4 MB" }

	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/i]

	validates_attachment :image, :presence => true

	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

    def Asset.per_page
      10
    end
  
    def check_assets_limit
    if User.find(self.user_id).reached_assets_limit?
      self.errors[:base] << "Cannot add any more Assets"
    end
  end


end
