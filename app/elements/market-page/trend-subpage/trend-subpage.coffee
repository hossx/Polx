'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'trend-subpage',
  msgMap:
    'en':
      priceChart: "Price Chart"
      buzz: "Tweets"
      trade: "Trade "

    'zh':
      priceChart: "价格图"
      buzz: "相关微博"
      trade: "买卖"

  ready: () ->
    @M = @msgMap[window.lang]

  active: false
  market: null
  showWeibo: false
  showTweets: false
  currency: null

  marketChanged: (o, n) ->
    if @market
      @currency = @market.currency
      if window.lang == "zh"
        @showWeibo = true
      else
        @showWeibo = false

      if window.lang == "en" and @currency.json.twitterWidgetId
        @showTweets = true
      else
        @showTweets = false
