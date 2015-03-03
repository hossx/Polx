'use strict'

Polymer 'api-get-google-auth',

  created:() -> @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @authUrl= @data.authUrl
      @secret = @data.secret

  updateUrl:() ->
    @url = '%s/googleauth/get'.format(@base())
