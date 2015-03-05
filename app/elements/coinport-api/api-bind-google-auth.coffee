'use strict'

Polymer 'api-bind-google-auth',
  bindGoogleAuth: (secret, code) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"googlesecret": "%s", "googlecode": "%s"}'.format(secret, code)
    @url = '%s/api/v2/user/bind_google_auth'.format(@base())
    @go()
