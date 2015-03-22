'use strict'

Polymer 'deposit-subpage',
  depositAddress: ''
  addresses: {}
  nxtAddressComponents: []
  selectedBalance: 0

  created: () ->
    @M = window.M['account']['deposit']
    @lang = window.lang
    @profile = window.profile
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies).sort()

    #this.$.newAddressAjax.createAddress('BTC')

  observe: {
    balance: 'onChange' 
    addresses: 'onChange'
  }

  currencyIdChanged: (o, n) ->
    @deposits = []
    if @currencyId
      @currency = @config.currencies[@currencyId]
      @onChange()

  onChange: () ->
    if @currencyId
      if @addresses and @addresses[@currencyId] and @addresses[@currencyId].length > 0
        @depositAddress = @addresses[@currencyId]
        if @currencyId == 'NXT'
          @nxtAddressComponents = @depositAddress.split("//")
      else
         @depositAddress = ''

      if @balance and @balance[@currencyId]
        @selectedBalance = @balance[@currencyId][3]
      else
        @selectedBalance = 0

    else
      @depositAddress = ''
      @selectedBalance = 0

      
  statusLabel: (s) -> @M['statusLabels'][(s or 0).toString()]
  formatTime: (t) -> moment(t).format("YYYY/MM/DD-hh:mm")
  loadMore: () -> this.$.depositsAjax.loadMore()
