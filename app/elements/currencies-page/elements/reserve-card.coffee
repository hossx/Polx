'use strict'

Polymer 'reserve-card',
  msgMap:
    'en':
      reserveRatio: "Reserve Ratio"
      hotWallet: "Hot Wallet"
      coldWallet: "Cold Wallet"
      userWallet: "User Wallet"
      shortage: "Shortage"
      extra: "Abundance"
      labels: ["Hot Wallet", "Cold Wallet", "User Wallet", "Abundance","Shortage"]

    'zh':
      reserveRatio: "准备金比例"
      hotWallet: "热钱包"
      coldWallet: "冷钱包"
      userWallet: "用户钱包"
      shortage: "缺口"
      extra: "盈余"
      labels: ["热钱包", "冷钱包", "用户钱包", "盈余","缺口"]


  currencyId: ''
  currency: null
  reserve: null
  reserveRatio: 0
  hotRatio: 0
  coldRatio: 0
  userRatio: 0
  shortageRatio: 0
  extraRatio: 0

  ready: () ->
    @M = @msgMap[window.lang]
    @asset = []
    @labels = @M.labels
    @colors = ['#9CCC65','#8BC34A','#AED581','#00e5ff','#ff2d6f']

  currencyIdChanged: (o, n) ->
    @currency = window.config.currencies[@currencyId]
    console.error("currency not found: " + @currencyId) if not @currency

  reserveChanged: (o, n) ->
    if @reserve
      balance =  @reserve[3]
      @shortage = balance - @reserve[0] - @reserve[1] - @reserve[2]

      if @shortage >= 0.0001
        @shortageRatio = 100* @shortage/balance
      else if @shortage <= - 0.0001
        @extraRatio = -100* @shortage/balance

      @hotRatio = 100 * @reserve[0]/balance
      @coldRatio = 100 * @reserve[1]/balance
      @userRatio = 100 * @reserve[2]/balance
      @reserveRatio = @hotRatio + @coldRatio + @userRatio 

      @needWarn = @reserveRatio <= window.config.viewParams.reserveRatioWarningThreshold
      if @shortageRatio > 0
        @asset = [@reserve[0], @reserve[1], @reserve[2], 0, @shortage]
      else if @extraRatio > 0
        @asset = [@reserve[0], @reserve[1], @reserve[2], -@shortage, 0]
      else
        @asset = [@reserve[0], @reserve[1], @reserve[2], 0, 0]


  ratioFormat: (value) ->
    value.toFixed(2) + "%"