'use strict'

Polymer 'api-register',
  email: ''
  password: ''

  register: () ->
    @withCredentials = false
    @url = '%s/api/v2/register'.format(window.config.api.base)
    pwdhash = Base64.encode($.sha256(@password))
    @method = 'POST'
    @contentType = 'application/json'
    console.log(pwdhash)
    @body = '{"email": "%s", "pwdhash": "%s"}'.format(@email, pwdhash)
    @go()
    
  responseChanged: (o, n) ->
    @result = @response
    if @result and (not @result.code or @result.code == 0) and @result.uid and @result.uid > 0
      @fire('user-register-ok')
    else
      @fire('user-register-failed')
      