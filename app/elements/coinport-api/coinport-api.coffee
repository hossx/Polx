Polymer 'coinport-api',

  msgMap:
    'en':
      serviceUnavailable: "Service is temporarily unavailable."

    'zh':
     serviceUnavailable: "币丰港服务暂时不可用。是不是你的网络有问题啦？"

  ready: ()->
    #@withCredentials = true
    @M = @msgMap[window.lang]
    `this.super()`

  parseCookie: (name) ->
    pairs = document.cookie.split(/\s*;\s*/)
    map = pairs.map (kv) ->
      eq = kv.indexOf('=')
      {
        name: unescape(kv.slice(0, eq))
        value: unescape(kv.slice(eq + 1))
      }
    kv = map.filter((kv) ->  kv.name == name)[0]
    if kv and kv.value then kv.value else null

  go: () ->
    value = @parseCookie('XSRF-TOKEN')
    if value
      headers = @headers or {}
      headers['X-XSRF-TOKEN'] = value
    
    # TO BE REMOVED !!!!!!!!

    headers['Authorization'] = "Basic " + Base64.encode("d@coinport.com:freshforce")
    console.log(headers)

    @headers = headers
    console.debug("fetching : " + @url)
    `this.super()`

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

