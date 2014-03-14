class CodelessValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
	  record.errors.add attribute, "has unacceptable characters." if value =~ /<.*>/m
	end
end