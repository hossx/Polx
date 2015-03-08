'use strict'

Polymer 'section-news',
  newsFile: ''
  news: ''
  newsLinted: ''

  marketChanged: (o, n) ->
    if @market
      @newsFile = "/markdown/markets/%s_news_%s.md".format(@market.id, window.lang)
      console.log(@newsFile)

  newsChanged: (o, n) ->
    if @news and @news.indexOf(window.config.wikiPrefix) == 0
      @newsLinted = @news.substring(window.config.wikiPrefix.length)
    else
      @newsLinted = ''