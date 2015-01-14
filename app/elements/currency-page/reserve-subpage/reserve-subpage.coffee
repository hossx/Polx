'use strict'

Polymer 'reserve-subpage',
  wiki: ''
  wikiLinted: ''
  details: null
  detailsUrl: ''

  currencyChanged: () ->
    @detailsUrl = window.protocol.reserveDetailsUrl(@currency.id)

  detailsChanged: (o, n) ->

  wikiChanged: (o, n) ->
    prefix = "coinport:wiki\n"
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)
