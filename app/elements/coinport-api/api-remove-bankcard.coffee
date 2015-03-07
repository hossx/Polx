'use strict'

Polymer 'api-remove-bankcard',
  removeCard: (cardNumber) ->
    @headers['Content-Type'] = 'application/json'  if @headers
    @contentType = 'application/json'
    @method = 'POST'
    @body ='{"cardNumber":"%s"}'.format(cardNumber)
    @url = '%s/api/v2/user/delete_bankcard'.format(@base())
    @go()
