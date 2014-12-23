'use strict'

class Coin
  constructor: (@id, @json) ->
    console.log("id: " + @id + ", json: " + JSON.stringify(@json))
    @name = @json.name

class Market
  constructor: (@baseCoin, @coin, @json) ->
    @id = @baseCoin.id + "-" + @coin.id
    @shortName = @coin.id + "/" + @baseCoin.id
    @name = @coin.name +"(" + @coin.id + ")/" + @baseCoin.id


Polymer
  route: ""
  ready: () ->
    saved = $.cookie('config')
    if saved
      @enrichConfig(JSON.parse(saved))
      console.log("config loaded from coookie: " + saved)

  onConfigLoaded: (event, data) ->
    @enrichConfig(data.response)
    configStr = JSON.stringify(data.response)
    $.cookie('config', configStr)
    console.log("config saved to cookie: " + configStr)
    this.$.loading.setAttribute("loaded","")
    this.$.router.setAttribute("loaded", "")

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
