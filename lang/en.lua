local translations = {
	text = {
		take_car = 'Take / Place Cone',
		take = 'Pickup Cone',
		place = 'Place Cone',
		resupply = 'Take / Put Back Cone'
	},
	notify = {
		take = 'You picked up a cone!',
		place = 'You placed a cone!',
		put_back = 'You put back a cone!',

		error_full = 'Cone stack is full!',
		error_empty = 'Cone stack is empty!',
		error_inhand = 'You already have a cone!'
	}
}

Lang = Lang or Locale:new({
	phrases = translations,
	warnOnMissing = true
})
