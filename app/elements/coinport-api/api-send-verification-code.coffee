'use strict'

Polymer 'api-send-verification-code',
  getCode: (toPhone, toEmail) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"toPhone": %s, "toEmail": %s}'.format(toPhone, toEmail)
    @url = '%s/api/v2/user/send_verification_code'.format(@base())
    @go()

  dataChanged: (o, n) ->
    if @data
      @phoneUuid = @data.phoneUuid
      @emailUuid = @data.emailUuid
