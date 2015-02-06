'use strict'

Polymer 'coinport-api',
  msgMap:
    'en':
      serviceUnavailable: "Service is temporarily unavailable."

    'zh':
     serviceUnavailable: "币丰港服务暂时不可用。是不是你的网络有问题啦？"

  created: ()->
    @M = @msgMap[window.lang]

  urlChanged: () ->
    console.debug("fetching : " + @url)

  processError: (xhr) ->
    @data = null
    if xhr.status == 401
      @fire('logout-requested')
    else
      console.error("unexpected status code: " + xhr.status)
      @fire('display-message', {'error': @M.serviceUnavailable})
    
  processResponse: (xhr) ->
    if not xhr.responseText
      @fire('display-message', {'error': @M.serviceUnavailable})
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



