'use strict'

Polymer
  route: ""
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
