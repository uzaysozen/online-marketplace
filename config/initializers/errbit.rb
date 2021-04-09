Airbrake.configure do |config|
  config.api_key = 'e78f7f6bbc7219fd3467f88ae5b9e516'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end