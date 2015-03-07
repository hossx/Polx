'use strict'

Polymer 'api-set-email-auth',
  setEmailAuth: (uuid, emailCode, emailPrefer) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"uuid": "%s", "emailCode": "%s", "emailPrefer": "%s"}'.format(uuid, emailCode, emailPrefer)
    @url = '%s/api/v2/user/set_email_auth'.format(@base())
    @go()
