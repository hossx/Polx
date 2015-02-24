'use strict'

Polymer 'about-subpage',
  msgMap:
    'en':
      trend: "Price Trend"
      about: "About"
      buzz: "Tweets"
      trade: "Trade "
      market: "Market"

    'zh':
      trend: "价格走势"
      about: "关于"
      buzz: "相关微博"
      trade: "买卖"
      market: "市场"

  ready: () ->
    @M = @msgMap[window.lang]

  tab: 0
  currency: null
  wikiFile: ''
  wiki: ''
  wikiLinted: ''
  markets: []
  candles: []
  showTweets: false
  showWeibo: false

  wikiChanged: (o, n) ->
    if @wiki and @wiki.indexOf(window.config.wikiPrefix) == 0
      @wikiLinted = @wiki.substring(window.config.wikiPrefix.length)

  currencyChanged: (o, n) ->
    @markets =[]
    if @currency
      @wikiFile = "/markdown/currencies/%s_%s.md".format(@currency.id, window.lang)

      if window.lang == "zh"
        @showWeibo = true
      else
        @showWeibo = false

      if window.lang == "en" and @currency.json.twitterWidgetId
        @showTweets = true
      else
        @showTweets = false

      markets = []
      for k, m of window.config.markets
        if m.currency.id == @currency.id
          markets.push m
      @markets = markets
