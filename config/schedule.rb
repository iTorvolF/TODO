set :chronic_options, hours24: true

every 1.day, at: '06:00' do
  rake 'deadline:emails'
end