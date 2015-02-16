'use strict'

Polymer 'api-my-deposits',
  currencyId: null
  cursor: 0
  limit: 50

  hasMore: false
  deposits: []

  observe:
    currencyId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  onChange: () ->
    if @currencyId
      @url = window.protocol.userDepositsUrl(@currencyId,@cursor,@limit)

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      @deposits = @data.deposits
