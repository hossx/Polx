'use strict'

Polymer
  route: ""

  ready: () ->
    saved = $.cookie('config')
    if saved
      @enrichConfig(JSON.parse(saved))
      console.log("config loaded from coookie: " + saved)

  handleConfig: (event, data) ->
    @enrichConfig(data.response)
    configStr = JSON.stringify(data.response)
    $.cookie('config', configStr)
    console.log("config saved to cookie: " + configStr)

  enrichConfig: (config) ->
    window.config = config
    console.log("config attached: " + config)


  created: () ->
    this.marketConfig =
      btcMarkets: ["LTC", "BTSX"]
      cnyMarkets: ["BTC", "LTC", "BTSX"]
      currencies:
        "CNY":
          "label": "Chinese Yuan"
        "BTC":
          "label": "Bitcoin"
        "LTC":
          "label": "Litecoin"
        "BTSX":
          "label": "BitsharesX"
