require 'sinatra'
require 'feralchimp'
require 'json'

Feralchimp.api_key = '3bbafb50ec8cd3af61c645d689281a8f-us4'

post '/' do
  content_type :json

  begin
    response = Feralchimp.lists_subscribe(
      id: 'FBA519F75E',
      email: params[:email],
      merge_vars: normalize_merge_vars(params[:merge_vars]),
      double_optin: false,
      update_existing: true,
      replace_interests: false,
      send_welcome: false
    )
  rescue MailchimpError => error
    response = { error: error.message }
  end

  response.to_json
end

def normalize_merge_vars(params)
  normalized_vars = {}
  params.each do |key, value|
    normalized_vars[key.upcase[0..9]] = value
  end
  normalized_vars
end