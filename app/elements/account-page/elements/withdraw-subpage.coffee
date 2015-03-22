'use strict'

Polymer 'withdraw-subpage',
  feeMap:
    'en':
        'CNY':
            'l': 2
            'f': "0.4% (at least 2 CNY)"
        'BTC':
            'l': 0.01
            'f': "0.0005 BTC"
        'LTC':
            "l": 0.01
            "f": "0.0005 LTC"
        'DOGE':
            "l": 5
            "f": "2 DOGE"
        'BC':
            "l": 0.01
            "f": "0.0005 BC"
        'DRK':
            "l": 0.01
            "f": "0.0005 DRK"
        'VRC':
            "l": 0.01
            "f": "0.0005 VRC"
        'ZET':
            "l": 0.01
            "f": "0.0005 ZET"
        'BTSX':
            "l": 10
            "f": "2 BTSX"
        'NXT':
            "l": 10
            "f": "2 NXT"
        'XRP':
            "l": 10
            "f": "1 XRP"
        'GOOC':
            "l": 1000
            "f": "0 GOOC"
    'zh':
        'CNY':
            'l': 2
            'f': "0.4% (最小2元)"
        'BTC':
            'l': 0.01
            'f': "0.0005 BTC"
        'LTC':
            "l": 0.01
            "f": "0.0005 LTC"
        'DOGE':
            "l": 5
            "f": "2 DOGE"
        'BC':
            "l": 0.01
            "f": "0.0005 BC"
        'DRK':
            "l": 0.01
            "f": "0.0005 DRK"
        'VRC':
            "l": 0.01
            "f": "0.0005 VRC"
        'ZET':
            "l": 0.01
            "f": "0.0005 ZET"
        'BTSX':
            "l": 10
            "f": "2 BTSX"
        'NXT':
            "l": 10
            "f": "2 NXT"
        'XRP':
            "l": 10
            "f": "1 XRP"
        'GOOC':
            "l": 1000
            "f": "0 GOOC"

  selectedBalance: 0

  created: () ->
    @M = window.M['account']['withdraw']
    @fee = @feeMap[window.lang]
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
    @M.withdrawalDesc.format(@fee[currency]['l'], currency, @fee[currency]['f'])

  getWithdrawalLimit: (currency) ->
    if !currency
      currency = 'BTC'
    @feeMap[window.lang][currency]['l']

  onWithdrawSucceed: (e) ->
      this.$.withdrawalsAjax.go()

  genMessage: (format, content) ->
      format.format.apply(format, content)
