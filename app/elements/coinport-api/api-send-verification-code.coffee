'use strict'

Polymer 'api-send-verification-code',
  getCode: (toPhone, toEmail) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"toPhone":"%s","toEmail":"%s","exchangeVersion":"v2","lang":"%s"}'.format(toPhone,toEmail,window.lang)
    @url = '%s/api/v2/user/send_verification_code'.format(@base())
    @go()

  dataChanged: (o, n) ->
    if @data
      @phoneUuid = @data.phoneUuid
      @emailUuid = @data.emailUuid
