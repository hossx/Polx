'use strict'

Polymer 'api-currency-balance-snapshots',
  hasMore: false
  continueLoading: false

  currencyId: ''
  limit: 40
  cursor: 0

  observe: {
    currencyId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'
  }

  onChange: () -> @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @path = @data.path
      @hasMore = @data.hasMore
      if @continueLoading
        @snapshots.push @data.items...
      else
        @snapshots = @data.items
    #@cursor = @snapshots[@snapshots.length-1][0000fdafdafaf]
    @continueLoading = false

  loadMore: () ->
    @continueLoading = true
    @go()

  updateUrl: () ->
    if @currencyId
      limit = if @limit > 0 then @limit else 40
      url = '%s/api/v2/%s/balance_snapshot_files'.format(@base(), @currencyId.toLowerCase(), limit)
      url = url + "&cursor=" + @cursor if @cursor > 0
      @url = url
