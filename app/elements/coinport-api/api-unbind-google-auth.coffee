'use strict'

Polymer 'api-unbind-google-auth',
  unbindGoogleAuth: (code) ->
      @headers['Content-Type'] = 'application/json'  if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @body ='{"googlecode": "%s"}'.format(code)
      @url = '%s/api/v2/user/unbind_google_auth'.format(@base())
      @go()
