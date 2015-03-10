'use strict'

Polymer 'api-currency-balance-snapshots',
  hasMore: false
  loadingMore: false
  tailCursor: 0

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
      if @loadingMore
        @loadingMore = false
        @snapshots.push @data.items...
      else
        @snapshots = @data.items

      len = @snapshots.length
      if len >= 1
        @tailCursor = @snapshots[len-1][2]
        console.log(@tailCursor) 

  loadMore: () ->
    @loadingMore = true
    @cursor = @tailCursor

  updateUrl: () ->
    if @currencyId
      limit = if @limit > 0 then @limit else 40
      url = '%s/api/v2/%s/balance_snapshot_files'.format(@base(), @currencyId.toLowerCase(), limit)
      url = url + "?cursor=" + @cursor if @cursor > 0
      @url = url
