'use strict'

Polymer 'account-page',
  msgMap:
    'en':
      myAccount: 'My Account'
      tradeTooltip: 'Trade Now'

    'zh':
      myAccount: '我的账号'
      tradeTooltip: '交易'

  currencyId: 'BTC'

  ready: () ->
    @M = @msgMap[window.lang]
    @page = "assets"
    @addEventListener 'goto-account-subpage', (e) ->
      @gotoPage(e.detail.page, e.detail.currencyId)
    
  gotoPage: (page, currencyId) ->
      @currencyId = currencyId if currencyId
      @page = page if page

  pageChanged: (o, n) ->
    if n == 'deposit' or n == 'withdraw' or n == 'assets'
      this.$.balanceAjax.go()

    if n == 'profile' or n == 'withdraw'
      this.$.profileAjax.go()
