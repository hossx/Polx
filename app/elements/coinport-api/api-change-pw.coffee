'use strict'

Polymer 'api-change-pw',
  changePw: (email, oldPw, newPw) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"email": "%s", "oldPassword": "%s", "newPassword": "%s"}'.format(email, oldPw, newPw)
    @url = '%s/api/v2/user/change_pwd'.format(@base())
    @go()
