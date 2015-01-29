'use strict'

Polymer 'cp-toolbar',
  msgMap:
    'en':
      coinport: "coinport"
      markets: "Markets"
      reserves: "Reserves"
      myAccount: "My Account"

    'zh':
      coinport: "币丰港"
      markets: "交易市场"
      reserves: "准备金"
      myAccount: "我的账号"

  ready: () ->
    @M = @msgMap[window.lang]

