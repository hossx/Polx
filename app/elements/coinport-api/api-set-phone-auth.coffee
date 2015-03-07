'use strict'

Polymer 'api-set-phone-auth',
  setPhoneAuth: (uuid, phoneCode, phonePrefer) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"uuid": "%s", "phoneCode": "%s", "phonePrefer": "%s"}'.format(uuid, phoneCode, phonePrefer)
    @url = '%s/api/v2/user/set_phone_auth'.format(@base())
    @go()
