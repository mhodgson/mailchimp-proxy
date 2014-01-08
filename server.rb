require 'sinatra'
require 'sinatra/cross_origin'
require 'feralchimp'
require 'json'

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :allow_credentials, true
set :max_age, "1728000"
set :expose_headers, ['Content-Type']

Feralchimp.api_key = '3bbafb50ec8cd3af61c645d689281a8f-us4'

post '/' do
  cross_origin
  content_type :json

  begin
    response = Feralchimp.lists_subscribe(
      id: 'FBA519F75E',
      email: { email: params[:email] },
      merge_vars: normalize_merge_vars(params[:merge_vars]),
      double_optin: false,
      update_existing: true,
      replace_interests: false,
      send_welcome: false
    )
    [200, response.to_json]
  rescue Feralchimp::MailchimpError => error
    [500, { error: error.message }.to_json]
  end
end

def normalize_merge_vars(params)
  normalized_vars = {}
  params.each do |key, value|
    normalized_vars[key.upcase[0..9]] = value
  end
  normalized_vars
end