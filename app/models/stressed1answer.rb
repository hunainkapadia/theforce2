class Stressed1answer < ActiveRecord::Base
	validates :sanswer, inclusion: [true, false]
end
