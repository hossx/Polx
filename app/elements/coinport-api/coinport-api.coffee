'use strict'

Polymer 'coinport-api',

  urlChanged: () ->
    console.log("url: " + @url)

  processError: (xhr) ->
    @data = null
    if xhr.status == 401
      @fire('logout-requested')
    else
      console.log("unexpected status code: " + xhr.status)
      @fire('network-error', {'url': @url})
    
  processResponse: (xhr) ->
    if not xhr.responseText
      @fire('network-error', {'url': @url})
      @data = null
    else
      try
        json = JSON.parse(xhr.responseText)
        if json and json.data
          @data = json.data
      catch x
        console.warn('core-ajax caught an exception trying to parse response as JSON:');
        console.warn('url:', this.url);
        console.warn(x);
        @data = null



