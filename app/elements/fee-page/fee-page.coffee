'use strict'

Polymer 'fee-page',
  created: () ->
    @M = window.M['fee']
    @config = window.config
    currencyKeys = Object.keys(@config.currencies).sort()

    fees1 = []
    for c in Object.keys(@config.currencies).sort()
      currency = @config.currencies[c]
      fees1.push
        currency: currency
        deposit: @getFee(currency, 'deposit', currency.unit)
        withdraw: @getFee(currency, 'withdraw', currency.unit)
    @fees1 = fees1

    fees2 = []
    for b in Object.keys(@config.marketGroups)
      markets = @config.marketGroups[b]
      for market in markets
        fees2.push
          market: market
          buyerFee: @getFee(market, 'trade', market.currency.unit)
          sellerFee: @getFee(market, 'trade', market.baseCurrency.unit)
    @fees2 = fees2
    console.log(fees2)

  getFee: (obj, kind, unit) ->
    if not obj or not obj.fee or not obj.fee.json or not obj.fee.json[kind]
      '0'
    else
      raw = obj.fee.json[kind]
      if raw.p
        if not raw.min
          raw.p + '% ' + unit 
        else
          @M.minimumPercentageFormat.format(raw.p, raw.min, unit)
      else if raw.c
        if not raw.min
          raw.c + ' ' + unit
        else
          @M.minimumConstantFormat.format(raw.c, raw.min, unit)
      else 
        '0'