'use strict'

Polymer 'api-bind-google-auth',

  bind: (secret, code) ->
      @headers['Content-Type'] = 'application/json'  if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @body ='{"googlecode": %s, "googlesecret": %s}'.format(code, secret)
      @url = '%s/api/v2/tbd'.format(@base())
      @go()

  dataChanged: (o, n) ->
    if @data
      @cancelledIds = @data.cancelled
      @failedIds = @data.failed
