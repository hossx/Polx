'use strict'

Polymer 'api-reset-password',

  resetPasswd: (token, password) ->
    @withCredentials = false
    @url = '%s/api/v2/reset_password'.format(window.config.api.base)
    pwdhash = $.sha256b64(password)
    @method = 'POST'
    @contentType = 'application/json'
    @body = '{"token":"%s","pwdHash":"%s"}'.format(token, pwdhash)
    console.log(@body)
    @go()
    
  codeChanged: (o, n) ->
    console.log(@response)
    ok = @code == 0
    @fire('change-password-done', {ok: ok, code: @code})
      