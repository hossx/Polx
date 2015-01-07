'use strict'

Polymer 'data-table',
  url: ''
  data: null

  respChanged: (o, n) ->
    if @resp 
      if @resp == ''
        @fire('network-error', {'url': @url})
      else if @resp.code != 0
        @fire('server-error', {'url': @url})
      else
        @data = @resp.data
        @hasMore = @data.hasMore || false
        console.log(@data)


  loadMore: () ->