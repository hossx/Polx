'use strict'

Polymer 'api-identity-verify',
  identityVerify: (realName, location, identiType, idNumber) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"realName": "%s", "location": "%s", "identiType": "%s", "idNumber": "%s"}'.format(
        realName, location, identiType, idNumber)
    @url = '%s/api/v2/user/verify_realname'.format(@base())
    @go()
