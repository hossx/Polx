'use strict'

Polymer 'api-market-depth',
  marketId: ''
  limit: 50
  cursor: 0

  bids: []
  asks: []
  bidsReverse: []
  spread: 0
    
  observe:
    marketId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'

  created: () -> @updateUrl()
  onChange: (o, n) -> @updateUrl()

  updateUrl: () ->
    if @marketId
      limit = if @limit > 0 then @limit else window.config.viewParams.market.orderBookInitialSize
      url = '%s/api/v2/%s/depth?limit=%s'.format(@base(), @marketId.toLowerCase(), limit)
      url = url + '&cursor=' + @cursor if @cursor > 0
      @url = url

  dataChanged: (o, n) ->
    if @data
      asks = []
      bids = []

      accumulated = 0
      for i in @data.asks
        accumulated = accumulated + i[1]
        asks.push
          price: i[0]
          quantity: i[1]
          total: i[0]*i[1]
          accumulated: accumulated
      
      accumulated = 0
      for i in @data.bids
        accumulated = accumulated + i[1]
        bids.push 
          price: i[0]
          quantity: i[1]
          total: i[0]*i[1]
          accumulated: accumulated

      @asks = asks
      @bids = bids
      @bidsReverse =  bids.slice().reverse()
      @spread = 
        if @asks.length > 0 and @bids.length > 0
          @asks[0].price - @bids[0].price
        else
          0
