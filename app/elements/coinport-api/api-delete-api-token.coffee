'use strict'

Polymer 'api-delete-api-token',
  deleteApiToken: (token) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"token": "%s"}'.format(token)
    @url = '%s/api/v2/user/delete_api_token'.format(@base())
    @go()
