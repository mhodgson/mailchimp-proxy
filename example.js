$.post("http://mailchimp-proxy.herokuapp.com/", {
  email: 'mhodgson@redbeard-tech.com',
  merge_vars: {
    utm_source: 'google',
    utm_medium: 'cpc',
    utm_campaign: 'matts_campaign',
    form_id: '123',
    http_referrer: 'http://www.google.com'
  }
});