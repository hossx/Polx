'use strict'

Polymer 'api-check-activation-code',
  ok: false

  check: (token) ->
    @withCredentials = false
    @url = '%s/api/v2/check_activation_code?token=%s'.format(window.config.api.base, token)
    @go()
    
  dataChanged: (o, n) ->
    console.log(@data)
    @ok = @data.result || false if @data
