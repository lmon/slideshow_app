class Asset < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries

has_attached_file :image, {
    :styles => {
      :thumb => ["50x50#", :png],
      :medium => ["100x100#", :png],
      :large => ["300x300>", :png]
    },
    :convert_options => {
      :thumb => "-gravity Center -crop 50x50+0+0",
      :thumb => "-gravity Center -crop 100x100+0+0",
    }
  }

  validates :user_id, :presence => true

  validates :name, presence: true
	validates :name, length: { in: 3..64 }

	validates :caption, length: { maximum: 512  }

	validates_attachment :image, :size => { :in => 0..4.megabytes }

	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]

	validates_attachment :image, :presence => true

	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

end
