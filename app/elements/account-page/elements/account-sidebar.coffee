'use strict'

Polymer 'account-sidebar',
  msgMap:
    'en':
      logout: "Logout"
      assets: "Assets"
      profile: "Profile"
      deposit: "Deposit"
      withdrawal: "Withdrawal"
      orders: "Orders"
      tradeHistory: "Trade History"

    'zh':
      logout: "登出"
      assets: "资产"
      profile: "账户"
      deposit: "充值"
      withdrawal: "提现"
      orders: "订单"
      tradeHistory: "成交"

  ready: () ->
    @M = @msgMap[window.lang]


  logout: () ->
    @fire('user-request-logout')
