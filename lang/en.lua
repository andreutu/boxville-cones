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
		put_back = 'You put back a cone!'
	}
}

Lang = Lang or Locale:new({
    phrases = translations,
	warnOnMissing = true
})