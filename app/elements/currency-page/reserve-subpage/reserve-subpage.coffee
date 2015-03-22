'use strict'

Polymer 'reserve-subpage',
  ready: () ->
    @M = window.M['currency']['reserve']

  wiki: ''
  wikiLinted: ''
  total: 0
  distribution: []

  distributionChanged: (o, n) ->
    if @distribution
      total = 0
      total = total + i[1] for i in @distribution
      @total = total

  wikiChanged: (o, n) ->
    prefix = 'coinport:wiki\n'
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)
