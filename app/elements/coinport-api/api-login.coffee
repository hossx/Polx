'use strict'

Polymer 'api-login',
  email: ''
  password: ''
  
  login: () ->
    if window.profile
      console.warn("window.profile not null, do not attemp to re-login")
      # redirect?
    else
      headers = @headers or {}
      headers['Authorization'] = "Basic " + Base64.encode(@email + ":" + @password)
      @headers = headers

      @url = window.protocol.loginUrl()
      @go()
    
  dataChanged: (o, n) ->
    if @data
      @profile = @data
      window.profile = @profile
      console.log(window.profile)
    else
      window.profile = null