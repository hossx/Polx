'use strict'

Polymer 'fee-page',
  msgMap:
    'en':
      depositWithdrawFees: "Deposit / Withdrawal Fee Table"
      tradingFees: "Trading Fee Table"
      currency: "Currency"
      market: "Market"
      depositFee: "Deposit Fee"
      withdrawFee: "Withdrawal Fee"
      buyerFee: "Buying Fee"
      sellerFee: "Selling Fee"
      minimumConstantFormat: "%s (Minimum %s %s)"
      minimumPercentageFormat: "%s% (Minimum %s %s)"
    'zh':
      depositWithdrawFees: "充值提现费率"
      tradingFees: "交易费率"
      currency: "货币"
      market: "市场"
      depositFee: "充值费率"
      withdrawFee: "提现费率"
      buyerFee: "买入费率"
      sellerFee: "卖出费率"
      minimumConstantFormat: "%s（最低：%s %s）"
      minimumPercentageFormat: "%s%（最低：%s %s）"

  created: () ->
    @M = @msgMap[window.lang]
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