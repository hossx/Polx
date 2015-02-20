'use strict'

Polymer 'api-login',
  email: ''
  password: ''

  login: () ->
    headers = @headers or {}
    headers['Authorization'] = "Basic " + Base64.encode(@email + ":" + @password)
    @headers = headers
    @withCredentials = false
    @url = '%s/api/v2/login'.format(window.config.api.base)
    @go()
    
  dataChanged: (o, n) ->
    if @data
      @profile = @data
      $.cookie('POLX_SESSION', JSON.stringify(@profile));
      window.profile = @profile
      @fire('user-logged-in')
