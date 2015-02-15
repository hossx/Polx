'use strict'

Polymer 'api-login',
  email: ''
  password: ''

  
  login: () ->
    headers = @headers or {}
    headers['Authorization'] = "Basic " + Base64.encode(@email + ":" + @password)
    @headers = headers
    @withCredentials = false
    @url = window.protocol.loginUrl()
    @go()
    
  dataChanged: (o, n) ->
    if @data
      @profile = @data
      window.profile = @profile
      $.cookie('profile', JSON.stringify(@profile));
      @fire('user-logged-in')
