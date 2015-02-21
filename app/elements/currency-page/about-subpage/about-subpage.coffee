'use strict'

Polymer 'about-subpage',
  msgMap:
    'en':
      trend: "Price Trend"
      about: "About"
      buzz: "Tweets"
      trade: "Trade "

    'zh':
      trend: "价格走势"
      about: "关于"
      buzz: "相关微博"
      trade: "买卖"

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
    prefix = "coinport:wiki\n"
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)

  currencyChanged: (o, n) ->
    @markets =[]
    if @currency
      if window.lang == "zh"
        @showWeibo = true
      else
        @showWeibo = false

      if window.lang == "en" and @currency.json.twitterWidgetId
        @showTweets = true
      else
        @showTweets = false


      @wikiFile = "../markdown/currencies/%s/%s.md".format(window.lang, @currency.id)
      for k, m of window.config.markets
        if m.currency.id == @currency.id
          @markets.push m
