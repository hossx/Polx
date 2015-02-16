Polymer 'coinport-api',

  msgMap:
    'en':
      serviceUnavailable: "Service is temporarily unavailable."
      internalServiceError: "We encountered an internal server error. Please report this to Coinport support team. (URL: %s)"

    'zh':
      serviceUnavailable: "币丰港服务暂时不可用。是不是你的网络有问题啦？"
      internalServiceError: "我们貌似遇到了一个后台服务内部错误，请联系币丰港客服提交一个bug吧。（URL: %s）"

  ready: ()->
    #@withCredentials = true
    @M = @msgMap[window.lang]
    @withCredentials = true # enable CORS
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
    xsrf = @parseCookie('XSRF-TOKEN')
    if xsrf
      headers = @headers or {}
      headers['X-XSRF-TOKEN'] = xsrf
      @headers = headers
      
    console.debug('fetching : "' + @url+'"')
    `this.super()`

  processError: (xhr) ->
    @data = null
    if xhr.status == 401
      window.profile = null
      $.removeCookie('profile')
      @fire('user-logged-out')
    else if xhr.status == 500
      console.error("500 response seen for url: " + @url)
      @fire('display-message', {'error': @M.internalServiceError.format(@url)})
    else
      console.error("unexpected status code: " + xhr.status)
      @fire('display-message', {'error': @M.serviceUnavailable})
    
  processResponse: (xhr) ->
    if xhr.status == 0
      @fire('display-message', {'error': @M.internalServiceError.format(@url)})
      @data = null
    else
      try
        if window.logAjax
          console.debug('"'+@url+'"')
          console.debug(xhr.responseText)
        json = JSON.parse(xhr.responseText)
        if json and json.data
          @data = json.data
      catch x
        console.warn('core-ajax caught an exception trying to parse response as JSON:');
        console.warn('url:', this.url);
        console.warn(x);
        @data = null

