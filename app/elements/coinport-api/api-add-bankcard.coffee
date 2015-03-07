'use strict'

Polymer 'api-add-bankcard',
  addCard: (bank, name, account, branch, emailUuid, emailCode) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"bankName":"%s", "U_RN":"%s", "cardNumber":"%s", "branchBankName":"%s", "emailUuid":"%s", "emailCode":"%s"}'.format(bank, name, account, branch, emailUuid, emailCode)
    @url = '%s/api/v2/user/add_bankcard'.format(@base())
    @go()
