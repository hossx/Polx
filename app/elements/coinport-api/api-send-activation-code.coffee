'use strict'

Polymer 'api-send-activation-code',

  request: (email) ->
    @withCredentials = false
    @method = 'POST'
    @contentType = 'application/json'
    @url = '%s/api/v2/send_activation_code'.format(window.config.api.base)
    @body = '{"email":"%s","exchangeVersion":"v2","lang":"%s"}'.format(email,window.lang)
    console.log(@body)
    @go()
    
  dataChanged: (o, n) ->
    console.log(@data)
    ok = if @data then @data.result else false 
    @fire('request-activation-code-done') # send this even there is a failure