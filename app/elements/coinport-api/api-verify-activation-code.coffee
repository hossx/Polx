'use strict'

Polymer 'api-verify-activation-code',

  check: (token) ->
    @withCredentials = false
    @url = '%s/api/v2/verify_activation_code?token=%s'.format(window.config.api.base, token)
    @go()
    
  dataChanged: (o, n) ->
    ok = if @data then @data.result else false 
    @fire('verify-email-done', {ok: ok})
