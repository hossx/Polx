'use strict'

Polymer 'api-verify-activation-code',

  verify: (token) ->
    @withCredentials = false
    @url = '%s/api/v2/verify_activation_code?token=%s'.format(window.config.api.base, token)
    @go()
    
  codeChanged: (o, n) ->
    ok = @code == 0 
    @fire('verify-email-done', {ok: ok})
