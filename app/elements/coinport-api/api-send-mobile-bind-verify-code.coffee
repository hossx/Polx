'use strict'

Polymer 'api-send-mobile-bind-verify-code',
  requireCode: (phoneNumber) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"phone":"%s","exchangeVersion":"v2","lang":"%s"}'.format(phoneNumber,window.lang)
    @url = '%s/api/v2/user/send_mobile_bind_verify_code'.format(@base())
    @go()

  dataChanged: (o, n) ->
    if @data
        @bindPhoneUuid = @data.phoneUuid
