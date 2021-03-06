describe 'User Stories' do

	let(:airport) { Airport.new(20, weather_reporter) }
	let(:plane) { Plane.new }
	let(:weather_reporter) { WeatherReporter.new }

	context 'when weather not stormy' do
		
		before do
			allow(weather_reporter).to receive(:stormy?).and_return false
		end

		# As an air traffic controller
		# So planes can land safely at my airport
		# I would like to instruct a plane to land

		it 'so planes land at airports, instruct a plane to land' do
			expect { airport.land(plane) }.not_to raise_error
		end

		# As an air traffic controller
		# So planes can take off safely from my airport
		# I would like to instruct a plane to take off

		it 'so planes can take off from airport, instruct a plane to take off' do
			airport.land(plane)
			expect { airport.take_off(plane) }.not_to raise_error
		end

		# As an air traffic controller
		# So that I can ensure safe take off procedures
		# I want planes to only take off from the airport they are at

		it 'takes off planes only from the airport they are at' do
			airport_2 = Airport.new(20, WeatherReporter.new)
			airport_2.land(plane)
			expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: plane is not at this airport.'
		end


		# As an air traffic controller
		# So that I can avoid collisions
		# I want to prevent airplanes landing when my airport is full

		context 'when airport is full' do
			it 'does not allow planes to land' do
				20.times do
					airport.land(plane)
				end
				expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full.'
			end
		
		end
	
	end


	context 'when weather stormy' do

		before do
			allow(weather_reporter).to receive(:stormy?).and_return true
		end

		# As an air traffic controller
		# So that I can avoid accidents
		# I want to prevent airplanes landing or taking off when the weather is stormy
		it 'does not allow planes to land' do
			expect { airport.land(plane) }.to raise_error 'Cannot land plane: weather is stormy.'
		end

		it 'does not allow planes to take off' do
			expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: weather is stormy.'
		end
	
	end

end