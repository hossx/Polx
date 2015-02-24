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
    console.log("=======")
    console.log(@wiki)
    prefix = "coinport:wiki\n"
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)
      console.log(@wikiLinted)

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
      console.log("-----")
      console.log(@showWeibo)
      console.log(@showTweets)
      @wikiFile = "/markdown/currencies/%s_%s.md".format(@currency.id, window.lang)
      console.log(@wikiFile)
      for k, m of window.config.markets
        if m.currency.id == @currency.id
          @markets.push m
