class Asset < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries

  default_scope -> { order('created_at DESC') }

  has_attached_file :image, {
    :styles => {
      :thumb => ["50x50#", :png],
      :medium => ["100x100#", :png],
      :large => ["300x300>", :png]
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

end
