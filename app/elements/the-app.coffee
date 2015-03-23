'use strict'

class CurrencyFee
  constructor:(@json) ->

class MarketFee
  constructor:(@json) ->

class Currency
  constructor: (@id, @json) ->
    @unit =
      if @json.unit
        @json.unit
      else
        @id
    @name = @json.name
    @fee = new CurrencyFee @json.fee
    @fullName = @name + "-" + @id
    @isCrypto = not @json.notCripto
    @icon = if not @json.icon then 'crypto:' + @id else @json.icon
    @group =
      if @isCrypto
        'CRYPTO'
      else
        'NON-CRYPTO'

class Market
  constructor: (@baseCurrency, @currency, @json) ->
    @id = @currency.id + "-" + @baseCurrency.id 
    @shortName = @currency.id + "/" + @baseCurrency.id
    @name = @currency.name + '-' + @currency.id + "/" + @baseCurrency.id
    @fee = new MarketFee @json.fee
    @pricePrecision = Math.min(@json.pricePrecision || 4, 8)
    @quantityPrecision = Math.min(@json.quantityPrecision || 4, 8)
    @totalPrecision = Math.min(@json.totalPrecision || 4, 4)
    @refreshInterval =
      if @json.refreshInterval
        @json.refreshInterval
      else
        window.config.refreshIntervals.depths
    @priceUnit =
      if @json.priceUnit
        @json.priceUnit
      else
        @currency.id + "/" + @baseCurrency.id
    @priceUnitOrEmptyString =
      if @json.priceUnit
        @json.priceUnit
      else
        ''

Polymer 'the-app',
  msgMap:
    'en':
      error: "Failed to load configurations!"
      errorComment: "(Please check your network connection.)"

    'zh':
      error: "无法加载应用配置！"
      errorComment: "（请检查网络连接）"

  route: ""

  configLoaded: false
  msgsLoaded: false

  ready: () ->
    @M = @msgMap[window.lang]
    $('#loading').remove()
    @configFile = "/configs/appconfig_" + window.lang + ".json"
    @msgFile = "/configs/messages_" + window.lang + ".json"

  onConfigLoaded: (event, data) ->
    try
      @enrichConfig(data.response)
      if @configLoaded and @msgsLoaded
        @initRouter()
    catch e
      console.error(e)
      this.$.error.removeAttribute("hide")

  onConfigError: (e) ->
    console.error(e)
    this.$.error.removeAttribute("hide")

  onMsgLoaded: (event, data) ->
    try
      @setupMsg(data.response)
      if @configLoaded and @msgsLoaded
        @initRouter()
    catch e
      console.error(e)

  onMsgError: (e) ->
    console.error(e)

  initRouter: () ->
    window.state = {}
    router = document.createElement('the-router')
    this.$.main.appendChild(router)
    router.setAttribute("show", "")

  processCurrenciesAndMarkets: () ->
    currencies = {}
    for k, v of window.config.currencies
      c = new Currency(k, v) 
      currencies[k] = c
    window.config.currencies = currencies

    currencyGroups = {}
    for k, c of window.config.currencies
      currencyGroups[c.group] = [] if not currencyGroups[c.group]
      currencyGroups[c.group].push c

    for k, v of currencyGroups
      currencyGroups[k] = v.sort (a, b) ->
        if a.id < b.id
          -1
        else
          1

    window.config.currencyGroups = currencyGroups

    markets = {}
    marketGroups = {}
    for baseCurrency, v of window.config.marketGroups
      for currency, v of v.markets
        market = new Market(currencies[baseCurrency], currencies[currency], v)
        markets[market.id] = market
        marketGroups[market.baseCurrency.id] = [] if not marketGroups[market.baseCurrency.id]
        marketGroups[market.baseCurrency.id].push market

    window.config.markets = markets
    window.config.marketGroups = marketGroups
    window.config.marketsForCurrency = (coin) ->
      results = []
      for k, market of markets
        results.push market if market.baseCurrency.id == coin or market.currency.id == coin
      results.sort (a, b) -> 
        if a.baseCurrency.id < b.baseCurrency.id
          -1
        else if a.baseCurrency.id > b.baseCurrency.id
          1
        else if a.currency.id < b.currency.id
          -1
        else
          1

  processDocuments: (config) ->
    tagMap = {}
    for k, v of window.config.documents
      for tag in v.tags 
        tagMap[tag] = {} if not tagMap[tag]
        tagMap[tag][k] = v

    window.config.documentTagMap = tagMap


  enrichConfig: (config) ->
    window.config = config
    @processCurrenciesAndMarkets()
    @processDocuments()
    window.config.emailRe = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
    window.config.wikiPrefix = "coinport:wiki\n"
    window.config.chartFonts = "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"
    
    console.debug("Loaded dynamic app-configurations:")
    console.dir(window.config)
    @configLoaded = true

  setupMsg: (messages) ->
    window.M = messages
    @msgsLoaded = true




