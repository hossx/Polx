'use strict'

Polymer 'about-subpage',
  msgMap:
    'en':
      trend: "Price Trend"
      about: "About"
      buzz: "Buzz"

    'zh':
      trend: "价格走势"
      about: "关于"
      buzz: "相关微博"

  ready: () ->
    @M = @msgMap[window.lang]

  currency: null
  wikiFile: ''
  wiki: ''
  wikiLinted: ''
  markets: []

  wikiChanged: (o, n) ->
    prefix = "coinport:wiki\n"
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)

  currencyChanged: (o, n) ->
    @markets =[]
    if @currency
      @wikiFile = "../markdown/currencies/%s/%s.md".format(window.lang, @currency.id)
      for k, m of window.config.markets
        if m.currency.id == @currency.id
          @markets.push m
