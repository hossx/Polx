'use strict'

Polymer 'account-page',
  msgMap:
    'en':
      myAccount: 'My Account'
      tradeTooltip: 'Trade Now'

    'zh':
      myAccount: '我的账号'
      tradeTooltip: '交易'

  page: 'withdraw'
  currencyId: 'BTC'

  ready: () ->
    @M = @msgMap[window.lang]
    @addEventListener 'goto-account-subpage', (e) ->
      @gotoPage(e.detail.page, e.detail.currencyId)

  gotoPage: (page, currencyId) ->
      @currencyId = currencyId if currencyId
      @page = page if page

  pageChanged: (o, n) ->
    if n == 'deposit' or n == 'withdraw' or n == 'assets'
      this.$.balanceAjax.go()

    if n == 'profile'
      this.$.profileAjax.go()

  profileChanged: (o, n) ->
    if @profile and @profile.name
      name  = @profile.name
      z = window.$zopim
      if z
        z () -> z.livechat.setName(name)