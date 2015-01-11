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
    @fullName = @name + " / " + @id
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
    @name = @currency.name + "  [" + @currency.id + "-" + @baseCurrency.id+"]"
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
  route: ""

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
    router.setAttribute("show","")

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
      tickerUrl: (coin) -> "%s/api/m/ticker/%s".format(@base, coin.toLowerCase())
      depthUrl: (market,limit) ->  "%s/api/m/%s/depth?depth=%d".format(@base, market.toLowerCase(), limit)
      transactionsUrl: (market, limit) ->  "%s/api/%s/transaction?limit=%d".format(@base, market.toLowerCase(), limit)
      cryptoTxsUrl: (coin) -> 'api_mock_open_crypto_txs.json'
      reserveStatsUrl: () -> 'api_mock_open_reserve_stats.json'
      reserveDetailsUrl: (coin) -> 'api_mock_open_reserve_details.json'
      reserveSnapshotsUrl: (coin) -> 'api_mock_open_reserve_snapshots.json'
      ## private apis
      userProfileUrl: 'api_mock_my_profile.json'
      userAssetsUrl:  'api_mock_my_assets.json'
      userDepositsUrl: (coin) -> 'api_mock_my_deposits.json'


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






