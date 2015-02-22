'use strict'

Polymer 'account-page',
  msgMap:
    'en':
      myAccount: "My Account"
      tradeTooltip: "Trade Now"

    'zh':
      myAccount: "我的账号"
      tradeTooltip: "交易"

  page: "withdraw"
  currencyId: 'BTC'

  ready: () ->
    @M = @msgMap[window.lang]

  pageChanged: (o, n) ->
    if o == 'deposit' or n == 'deposit' or o == 'withdraw' or n == 'withdraw'
      this.$.balanceAjax.go()
      
    if o == 'profile' or n == 'profile'
      this.$.profileAjax.go()
    