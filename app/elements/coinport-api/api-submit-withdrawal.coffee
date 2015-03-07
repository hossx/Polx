'use strict'

Polymer 'api-submit-withdrawal',
  withdraw: (currency, address, amount, emailUuid, emailCode, phoneUuid, phoneCode, googleCode, nxtPubkey, memo, version, lang) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"currency": "%s", "address": "%s", "amount": %f, "emailUuid": "%s", "emailCode": "%s", "phoneUuid": "%s", "phoneCode": "%s", "googleCode": "%s", "nxt_public_key": "%s", "memo": "%s", "exchangeVersion": "%s", "lang": "%s"}'.format(
      currency, address, amount, emailUuid, emailCode, phoneUuid, phoneCode, googleCode, nxtPubkey, memo, version, lang)
    @url = '%s/api/v2/user/submit_withdrawal'.format(@base())
    @go()
