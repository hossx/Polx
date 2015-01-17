'use strict'

Polymer 'about-subpage',
  currency: null
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
      for k, m of window.config.markets
        if m.currency.id == @currency.id
          @markets.push m
