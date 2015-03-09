'use strict'

Polymer 'api-login',
  email: ''
  password: ''

  login: () ->
    headers = @headers or {}
    headers['Authorization'] = "Basic " + @email + ":" + $.sha256b64(@password)
    @headers = headers
    @withCredentials = false
    @url = '%s/api/v2/login'.format(window.config.api.base)
    @go()
    
  dataChanged: (o, n) ->
    if @data and @data.uid and @data.email
      @profile = @data
      $.cookie('POLX_SESSION', JSON.stringify(@profile));
      window.profile = @profile
      @fire('user-logged-in')