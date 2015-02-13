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
      loading: "Loading..."
      error: "Failed to load configurations!"
      errorComment: "(Please check your network connection.)"

    'zh':
      loading: "加载中..."
      error: "无法加载应用配置！"
      errorComment: "（请检查网络连接）"

  route: ""

  ready: () ->
    @M = @msgMap[window.lang]
    @configFile = "../appconfig_" + window.lang + ".json"

  onConfigLoaded: (event, data) ->
    try
      this.$.loading.setAttribute("hide", "")
      @enrichConfig(data.response)
    catch error
      console.error(error)
      this.$.error.removeAttribute("hide")

  initRouter: () ->
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

  processProtocols: () ->
    window.protocol =
      base: window.config.api.base
      ##
      registerUrl: () -> "%s/account/register".format(@base)
      loginUrl: () -> "%s/account/login".format(@base)
      logoutUrl:  () ->"%s/account/logout".format(@base)
      ## public apis
     
      currenciesReserveStatsUrl: () -> '%s/api/v2/reserve_stats'.format(@base)
      currencyReservesUrl: (coin) -> '%s/api/v2/%s/reserves'.format(@base, coin.toLowerCase())
      currencyBalanceSnapshotFilesUrl: (coin,cursor,limit) -> '%s/api/v2/%s/balance_snapshot_files'.format(@base, coin.toLowerCase(),cursor,limit)
      currencyTransfersUrl: (coin) -> '%s/api/v2/%s/transfers'.format(@base, coin.toLowerCase())


      marketsTickersUrl: (coin) -> "%s/api/v2/%s/tickers".format(@base, coin.toLowerCase())
      marketTickerUrl: (market) -> "%s/api/v2/%s/ticker".format(@base, market.toLowerCase())
      marketDepthUrl: (market,limit) ->  "%s/api/v2/%s/depth?limit=%s".format(@base, market.toLowerCase(), limit)
      marketTradesUrl: (market, limit) ->  "%s/api/v2/%s/trades?limit=%s".format(@base, market.toLowerCase(), limit)
      marketKlineUrl: (market, interval, start, end) -> '%s/api/v2/%s/kline?interval=%s&start=%s&end=%s'.format(@base, market.toLowerCase(), interval, start, end)
      

      ## private apis
      userOrdersUrl: (market) -> '%s/api/v2/user/orders?market=%s'.format(@base, market)
      userTradesUrl: (market) -> '%s/api/v2/user/trades?market=%s'.format(@base, market)
      userProfileUrl: 'api_mock_my_profile.json'
      userAssetsUrl:  'api_mock_my_assets.json'
      userDepositsUrl: (coin) -> 'api_mock_my_deposits.json'
      userCancelOrdersUrl: () -> '%s/api/v2/user/cancel_orders'.format(@base)
      userSubmitOrdersUrl: () -> '%s/api/v2/user/submit_orders'.format(@base)
      userBalanceUrl: () -> '%s/api/v2/user/balance'.format(@base)


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
    @processProtocols()
    @processDocuments()

    console.debug("Loaded dynamic app-configurations:")
    console.dir({"config": window.config, "protocol": window.protocol})

    window.state = {}
    window.state.currencyId = "BTC"

    @initRouter()






