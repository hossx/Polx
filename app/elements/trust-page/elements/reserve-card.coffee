'use strict'

Polymer 'reserve-card',
  currencyId: ''
  currency: null
  reserve: null
  reserveRatio: 0
  total: 0
  hotRatio: 0
  coldRatio: 0
  userRatio: 0
  missingRatio: 0


  ready: () ->
    @ratios = []
    @labels = []
    @colors = ['#54AEAA','#54AEAA','#54AEAA','#FE766A']

  currencyIdChanged: (o, n) ->
    @currency = window.config.currencies[@currencyId]
    console.error("currency not found: " + @currencyId) if not @currency

  reserveChanged: (o, n) ->
    if @reserve
      @total = @reserve[0] + @reserve[1] + @reserve[2] + @reserve[3]
      @missingRatio = Math.ceil(100 * @reserve[3]/@total)

      @hotRatio = Math.floor(100 * @reserve[0]/@total)
      @coldRatio = Math.floor(100 * @reserve[1]/@total)
      @userRatio =100 - @hotRatio - @coldRatio - @missingRatio
      @reserveRatio = 100 - @missingRatio

      @labels = [
        "Hot Wallet ("  + @ratioFormat(@hotRatio) + ")", 
        "Cold Wallet ("  + @ratioFormat(@coldRatio) + ")", 
        "User Wallet ("  + @ratioFormat(@userRatio) + ")", 
        "Missing ("  + @ratioFormat(@missingRatio) + ")"
      ]

  ratioFormat: (value) ->
    String(value).substring(0, 4) + "%"