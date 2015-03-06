'use strict'

Polymer 'api-bind-update-phone',
  bindUpdatePhone: (mobile, oldUuid, oldCode, newUuid, newCode) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"mobile": "%s", "verifyCodeUuidOld": "%s", "verifyCodeOld": "%s", "verifyCodeUuid": "%s", "verifyCode": "%s"}'.format(
        mobile, oldUuid, oldCode, newUuid, newCode)
    @url = '%s/api/v2/user/bind_or_update_mobile'.format(@base())
    @go()
