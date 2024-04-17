local translations = {
    text = {
		take_car = 'Take / Place Cone',
		take = 'Pickup Cone',
		place = 'Place Cone',
		resupply = 'Take / Put Back Cone'
	}
}

Lang = Lang or Locale:new({
    phrases = translations,
	warnOnMissing = true
})