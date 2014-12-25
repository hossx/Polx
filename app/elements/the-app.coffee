'use strict'

class CurrencyFee
  constructor:(@json) ->

class MarketFee
  constructor:(@json) ->

class Currency
  constructor: (@id, @json) ->
    @name = @json.name
    @fee = new CurrencyFee @json.fee

class Market
  constructor: (@baseCurrency, @currency, @json) ->
    @id = @baseCurrency.id + "-" + @currency.id
    @shortName = @currency.id + "/" + @baseCurrency.id
    @name = @currency.name + "(" + @currency.id + ")/" + @baseCurrency.id
    @fee = new MarketFee @json.fee



Polymer
  route: ""

  onConfigLoaded: (event, data) ->
    try
      this.$.loading.setAttribute("hide", "")
      @enrichConfig(data.response)
    catch error
      this.$.error.removeAttribute("hide")

  initRouter: () ->
    router = document.createElement('the-router')
    this.$.main.appendChild(router)
    router.setAttribute("show","")

  enrichConfig: (config) ->
    window.config = config

    currencies = {}
    currencies[k] = new Currency(k, v) for k, v of config.currencies
    window.config.currencies = currencies

    markets = {}
    marketGroups = {}
    for baseCurrency, v of config.marketGroups
      for currency, config of v.markets
        market = new Market(currencies[baseCurrency], currencies[currency], config)
        markets[market.id] = market
        defaultMarket = market if not defaultMarket
        marketGroups[market.baseCurrency.id] = [] if not marketGroups[market.baseCurrency.id]
        marketGroups[market.baseCurrency.id].push market

    window.config.defaultMarket = defaultMarket
    window.config.markets = markets
    window.config.marketGroups = marketGroups

    console.log("====== window.config: ")
    console.log(window.config)
    @initRouter()

   