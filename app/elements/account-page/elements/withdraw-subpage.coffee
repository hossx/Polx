'use strict'

Polymer 'withdraw-subpage',
  selectedBalance: 0

  created: () ->
    @M = window.M['account']['withdraw']
    @lang = window.lang
    @profile = window.profile
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies).sort()

    #this.$.newAddressAjax.createAddress('BTC')

  observe: {
    balance: 'onChange'
  }

  currencyIdChanged: (o, n) ->
    @withdrawals = []
    if @currencyId
      @currency = @config.currencies[@currencyId]
      @onChange()

  onChange: () ->
    if @currencyId
      if @balance and @balance[@currencyId]
        @selectedBalance = @balance[@currencyId][0]
      else
        @selectedBalance = 0
    else
      @selectedBalance = 0

  formatTime: (t) -> moment(t).format("YYYY/MM/DD-hh:mm")
  statusLabel: (i) -> @M['statusLabels'][(i or 0).toString()]

  loadMore: () ->
    this.$.withdrawalsAjax.loadMore()

  genWithdrawalDesc: (currency) ->
    if !currency
      currency = 'BTC'
    @M.withdrawalDesc.format(@currency['json']['lowLimit'], currency, @currency['fee']['json']['withdraw']['c'])

  getWithdrawalLimit: (currency) ->
    if !currency
      currency = 'BTC'
    @currency = @config['currencies'][currency]
    @currency['json']['lowLimit']

  onWithdrawSucceed: (e) ->
      this.$.withdrawalsAjax.go()

  genMessage: (format, content) ->
      format.format.apply(format, content)
