'use strict'

Polymer 'api-market-depth',
  
  limit: 50
  bids: []
  asks: []
  bidsReverse: []
  spread: 0

  observe:
    limit: 'onChange'
    marketId: 'onChange'

  onChange: (o, n) ->
    @url = window.protocol.depthUrl(@marketId, @limit)

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
