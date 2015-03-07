'use strict'

Polymer 'api-register',
  email: ''
  password: ''

  register: () ->
    @withCredentials = false
    @url = '%s/api/v2/register'.format(window.config.api.base)
    pwdhash = $.sha256b64(@password)
    @method = 'POST'
    @contentType = 'application/json'
    @body = '{"email":"%s","pwdhash":"%s","exchangeVersion":"v2","lang":"%s"}'.format(@email, pwdhash,window.lang)
    console.log(@body)
    @go()
    
  responseChanged: (o, n) ->
    if @response and (not @response.code or @response.code == 0) and @data and @data.uid and @data.uid > 0
      @fire('user-register-ok')
    else
      @fire('user-register-failed', {code: @result.code})
      