'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'trend-subpage',
  msgMap:
    'en':
      priceChart: "Price Chart"
      buzz: "Tweets"
      trade: "Trade "
      about: "About"

    'zh':
      priceChart: "价格图"
      buzz: "相关微博"
      trade: "买卖"
      about: "关于"

  ready: () ->
    @M = @msgMap[window.lang]

  active: false
  market: null
  currency: null
  wikiFile: ''
  wiki: ''
  wikiLinted: ''
  showWeibo: false
  showTweets: false

  wikiChanged: (o, n) ->
    if @wiki and @wiki.indexOf(window.config.wikiPrefix) == 0
      @wikiLinted = @wiki.substring(window.config.wikiPrefix.length)

  marketChanged: (o, n) ->
    if @market
      @currency = @market.currency
      @wikiFile = "/markdown/currencies/%s_%s.md".format(@currency.id, window.lang)

      if window.lang == "zh"
        @showWeibo = true
      else
        @showWeibo = false

      if window.lang == "en" and @currency.json.twitterWidgetId
        @showTweets = true
      else
        @showTweets = false

