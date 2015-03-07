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

    @triggerAjax(@page)

  gotoPage: (page, currencyId) ->
      @currencyId = currencyId if currencyId
      @page = page if page

  pageChanged: (o, n) -> @triggerAjax(n)

  triggerAjax: (p) ->
    if p == 'deposit' or p == 'withdraw' or p == 'assets'
      this.$.balanceAjax.go()

    if p == 'profile'
      this.$.profileAjax.go()

  profileChanged: (o, n) ->
    if @profile and @profile.name
      name  = @profile.name
      z = window.$zopim
      if z
        z () -> z.livechat.setName(name)