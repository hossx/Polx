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
    currencyGroups = {}
    for k, v of window.config.currencies
      c = new Currency(k, v) 
      currencies[k] = c
      currencyGroups[c.group] = [] if not currencyGroups[c.group]
      currencyGroups[c.group].push c

    window.config.currencies = currencies
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

  processProtocols: () ->
    window.protocol =
      base: window.config.api.base
      tickerUrl: (coin) -> "%s/api/m/ticker/%s".format(@base, coin.toLowerCase())
      depthUrl: (market) ->  "%s/api/m/%s/depth".format(@base, market.toLowerCase())
      transactionUrl: (market) ->  "%s/api/%s/transaction".format(@base, market.toLowerCase())
      currencyStatsUrl: () -> 'api_mock_currency_stats.json'
      currencyDetailsUrl: (coin) -> 'api_mock_currency_details.json'
      currencyTxsUrl: (coin) -> 'api_mock_currency_txs.json'
      currencySnapshotsUrl: (coin) -> 'api_mock_currency_snapshots.json'


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

    @initRouter()




