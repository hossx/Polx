'use strict'

Polymer 'coinport-api',

  processError: (xhr) ->
    @fire('network-error', {'url': @url})
    @data = null
  
  processResponse: (xhr) ->
    if not xhr.responseText
      console.log(xhr.responseText)
      @fire('network-error', {'url': @url})
      @data = null
    else if xhr.status == 200
      try
        json = JSON.parse(xhr.responseText)
        if json and json.data
          @data = json.data
      catch x
        console.warn('core-ajax caught an exception trying to parse response as JSON:');
        console.warn('url:', this.url);
        console.warn(x);
        @data = null
    else
      console.error("status: " + xhr.status)


