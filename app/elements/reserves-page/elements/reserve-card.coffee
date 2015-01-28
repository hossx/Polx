'use strict'

Polymer 'reserve-card',
  msgMap:
    'en':
      reserveRatio: "Reserve Ratio"
      hotWallet: "Hot Wallet"
      coldWallet: "Cold Wallet"
      userWallet: "User Wallet"
      shortage: "Shortage"

    'zh':
      reserveRatio: "保证金比例"
      hotWallet: "热钱包"
      coldWallet: "冷钱包"
      userWallet: "用户钱包"
      shortage: "缺口"


  currencyId: ''
  currency: null
  reserve: null
  reserveRatio: 0
  hotRatio: 0
  coldRatio: 0
  userRatio: 0
  shortageRatio: 0
  shortage: 0
  isShort: false


  ready: () ->
    @M = @msgMap[window.lang]
    @asset = []
    @labels = []
    @colors = ['#9CCC65','#8BC34A','#AED581','#EF5350']

  currencyIdChanged: (o, n) ->
    @currency = window.config.currencies[@currencyId]
    console.error("currency not found: " + @currencyId) if not @currency

  reserveChanged: (o, n) ->
    if @reserve
      balance =  @reserve[3]
      @shortage = balance - @reserve[0] - @reserve[1] - @reserve[2]
      @isShort = @shortage <= 0
      @shortageRatio = Math.ceil(100 * @shortage/balance)

      @hotRatio = Math.floor(100 * @reserve[0]/balance)
      @coldRatio = Math.floor(100 * @reserve[1]/balance)
      @userRatio =100 - @hotRatio - @coldRatio - @shortageRatio
      @reserveRatio = 100 - @shortageRatio
      if @shortage > 0
        @asset = [@reserve[0], @reserve[1], @reserve[2], @shortage]
      else 
        @asset = [@reserve[0], @reserve[1], @reserve[2]]

      @labels = [
        "Hot Wallet (" + @currency.unit + ")", 
        "Cold Wallet (" + @currency.unit + ")", 
        "User Wallet (" + @currency.unit + ")", 
        "Shortage (" + @currency.unit + ")"
      ]

  ratioFormat: (value) ->
    String(value).substring(0, 4) + "%"