'use strict'


Polymer 'api-my-withdrawals',
  currencyId: null
  cursor: 0
  limit: 50

  hasMore: false
  withdrawals: []

  observe:
    currencyId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  onChange: () ->
    @url = window.protocol.userWithdrawalsUrl(@currencyId,@cursor,@limit)

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      @withdrawals = @data.withdrawals
