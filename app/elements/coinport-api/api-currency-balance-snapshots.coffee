'use strict'

Polymer 'api-currency-balance-snapshots',
  hasMore: false
  continueLoading: false
  cursor: '0'
  limit: 40

  observe: {
    currencyId: 'paramsChanged'
    cursor: 'paramsChanged'
    limit: 'paramsChanged'
  }

  paramsChanged: () ->
    if @currencyId
      @url = window.protocol.currencyBalanceSnapshotFilesUrl(@currencyId, @cursor, @limit)

  dataChanged: (o, n) ->
    if @data
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

