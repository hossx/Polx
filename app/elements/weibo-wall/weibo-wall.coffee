'use strict'

Polymer 'weibo-wall',
  height: 800 
  tags: "no-tag"

  currencyChanged: () ->
    if @currency
      if @currency.json.tags
        tags = @currency.json.tags
      else
        tags = @currency.name
      @encodedTags = encodeURIComponent(tags)
