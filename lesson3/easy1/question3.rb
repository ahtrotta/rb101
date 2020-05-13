advice = "Few things in life are as important as house training your pet dinosaur."

advice = advice.split
advice[6] = 'urgent'
advice = advice.join(' ')
puts advice

# better answer
# advice.gsub!('important', 'urgent')
