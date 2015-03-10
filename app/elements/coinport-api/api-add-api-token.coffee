'use strict'

Polymer 'api-add-api-token',
  created: () ->
    @updateUrl()

  updateUrl: () ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{}'
    @url = "%s/api/v2/user/add_api_token".format(@base())
