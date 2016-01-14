class Happy1answer < ActiveRecord::Base
	validates :hanswer, inclusion: [true, false]
end
