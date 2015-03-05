'use strict'

Polymer 'api-get-google-auth',

  created:() -> @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @authUrl= @data.authUrl
      @secret = @data.secret

  updateUrl:() ->
    @url = '%s/api/v2/user/get_google_auth'.format(@base())
