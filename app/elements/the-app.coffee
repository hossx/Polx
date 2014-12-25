'use strict'

class Currency
  constructor: (@id, @json) ->
    @name = @json.name

class Market
  constructor: (@baseCoin, @coin, @json) ->
    @id = @baseCoin.id + "-" + @coin.id
    @shortName = @coin.id + "/" + @baseCoin.id
    @name = @coin.name + "(" + @coin.id + ")/" + @baseCoin.id

Polymer
  route: ""

  onConfigLoaded: (event, data) ->
    console.log("===STARTED LOADING CONFIGURATION===")
    try
      this.$.loading.setAttribute("hide", "")
      @enrichConfig(data.response)
      console.log("===CONFIGURATION LOADED===")
    catch error
      this.$.error.removeAttribute("hide")
      console.log("===CONFIGURATION LOADING FAILED===")

  enrichConfig: (config) ->
    window.config = config

    currencies = {}
    currencies[k] = new Currency(k, v) for k, v of config.currencies
    window.config.currencies = currencies

    markets = {}
    marketGroups = {}
    for base, v of config.marketGroups
      for coin, config of v.markets
        market = new Market(currencies[base], currencies[coin], config)
        markets[market.id] = market
        defaultMarket = market if not defaultMarket
        marketGroups[market.baseCoin.id] = [] if not marketGroups[market.baseCoin.id]
        marketGroups[market.baseCoin.id].push market

    window.config.defaultMarket = defaultMarket
    window.config.markets = markets
    window.config.marketGroups = marketGroups

    console.log("enriched: " + JSON.stringify(window.config))

    router = document.createElement('the-router')
    this.$.main.appendChild(router)
    router.setAttribute("show","")
