'use strict'

Polymer 'account-page',
  currencyId: 'BTC'

  ready: () ->
    @M = window.M['account']['account']
    @page = "assets"
    @setupEventListeners()

  gotoPage: (page, currencyId) ->
      @currencyId = currencyId if currencyId
      @page = page if page

  pageChanged: (o, n) ->
    if n == 'deposit' or n == 'withdraw' or n == 'assets'
      this.$.balanceAjax.go()

    if n == 'profile' or n == 'withdraw'
      this.$.profileAjax.go()

  setupEventListeners:() ->
    @addEventListener 'refresh-profile', (e) ->
      this.$.profileAjax.go()

    @addEventListener 'goto-account-subpage', (e) ->
      @gotoPage(e.detail.page, e.detail.currencyId)
