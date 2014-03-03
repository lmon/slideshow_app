class Contact < ActiveRecord::Base

	  class CodelessValidator < ActiveModel::EachValidator
	    def validate_each(record, attribute, value)
	      record.errors.add attribute, "Unacceptable characters." if value =~ /<.*>/m
	    end
	  end


	#validates :name, presence: true
	validates :name, length: { maximum: 32 }, codeless:  true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email, presence: true, 
  					format: { with: VALID_EMAIL_REGEX } 

	validates :email, length: { in: 6..64 }, codeless:  true

	validates :message, presence: true,
			 length: { in: 0..512 }
 
	validates :message, codeless:  true



end
