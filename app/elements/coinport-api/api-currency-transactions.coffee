'use strict'

Polymer 'api-currency-transactions',
  hasMore: false
  transactions: []

  currencyId: ''
  limit: 40
  cursor: 0

  observe:
    currencyId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'

  onChange: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      @transactions = @data.transfers

  updateUrl: () ->
    if @currencyId
      limit = if @limit > 0 then @limit else 40
      url = '%s/api/v2/%s/transfers?limit=%s'.format(@base(), @currencyId.toLowerCase(),limit)
      url = url + "&cursor=" + @cursor if @cursor > 0
      @url = url


  loadMore: () ->
    console.log("TODO")