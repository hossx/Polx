'use strict'

Polymer 'api-currency-transactions',
  hasMore: false

  currencyIdChanged: () ->
    if @currencyId
      @url = window.protocol.currencyTransfersUrl(@currencyId)
      console.log(@url)

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      @transactions = @data.transfers

