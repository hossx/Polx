'use strict'

Polymer 'api-currency-transactions',
  hasMore: false
  loadingMore: false
  tailCursor: 0

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
      if @loadingMore
        @loadingMore = false
        @transactions.push @data.transfers...
      else
        @transactions = @data.transfers

      len = @transactions.length
      if len >= 1
        @tailCursor = @transactions[len-1].id

  loadMore: () ->
    @loadingMore = true
    @cursor = @tailCursor

  updateUrl: () ->
    if @currencyId
      limit = if @limit > 0 then @limit else 40
      url = '%s/api/v2/%s/transfers?limit=%s'.format(@base(), @currencyId.toLowerCase(),limit)
      url = url + "&cursor=" + @cursor if @cursor > 0
      @url = url