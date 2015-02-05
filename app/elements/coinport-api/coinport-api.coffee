'use strict'

Polymer 'coinport-api',
  processError: (xhr) ->
    @fire('network-error', {'url': @url})
    @data = null
  
  processResponse: (xhr) ->
    if xhr.status == 401
      @data = null
      console.log("unauthorized")
      @fire('logout-requested')
      return

    if xhr.status != 200
      @data = null
      console.log("unexpected status code: " + xhr.status)
      return

    if not xhr.responseText
      @fire('network-error', {'url': @url})
      @data = null

    try
      json = JSON.parse(xhr.responseText)
      if json and json.data
        @data = json.data
    catch x
      console.warn('core-ajax caught an exception trying to parse response as JSON:');
      console.warn('url:', this.url);
      console.warn(x);
      @data = null



