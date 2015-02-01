'use strict'

Polymer 'coinport-api',
  
  processResponse: (xhr) ->
    if not xhr.responseText
      consolelog(xhr.responseText)
      # @fire('network-error', {'url': @depthUrl})
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


