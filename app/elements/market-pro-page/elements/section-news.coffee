'use strict'

Polymer 'section-news',
  msgMap:
    'en':
      noNews: "Not much to say ..."


    'zh':
      noNews: "好吧，还没什么新闻 ..."

  ready: () ->
    @M = @msgMap[window.lang]

  newsFile: ''
  news: ''
  newsLinted: ''

  marketChanged: (o, n) ->
    if @market
      @newsFile = "/markdown/markets/%s_news_%s.md".format(@market.id, window.lang)

  newsChanged: (o, n) ->
    if @news and @news.indexOf(window.config.wikiPrefix) == 0
      @newsLinted = @news.substring(window.config.wikiPrefix.length)
    else
      @newsLinted = @M.noNews