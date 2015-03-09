'use strict'

Polymer 'api-request-password-reset',

  request: (email) ->
    @withCredentials = false
    @method = 'POST'
    @contentType = 'application/json'
    @url = '%s/api/v2/request_password_reset'.format(window.config.api.base)
    @body = '{"email":"%s","exchangeVersion":"v2","lang":"%s"}'.format(email,window.lang)
    console.log(@body)
    @go()
    
  dataChanged: (o, n) ->
    console.log(@data)
    ok = if @data then @data.result else false 
    @fire('request-passwd-reset-done') # send this even there is a failure