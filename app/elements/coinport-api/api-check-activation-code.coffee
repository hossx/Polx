'use strict'

Polymer 'api-check-activation-code',

  check: (token) ->
    @withCredentials = false
    @url = '%s/api/v2/check_activation_code?token=%s'.format(window.config.api.base, token)
    @go()
    
  dataChanged: (o, n) ->
    console.log(@data)
    ok = if @data then @data.result else false 
    @fire('verify-email-done', {ok: ok})
