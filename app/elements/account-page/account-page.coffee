'use strict'

Polymer 'account-page',
  msgMap:
    'en':
      myAccount: "My Account"
      tradeTooltip: "Trade Now"

    'zh':
      myAccount: "我的账号"
      tradeTooltip: "交易"

  profileUrl: ''
  profileResp: null
  profile: null
  currencyId: ""

  ready: () ->
    @M = @msgMap[window.lang]
    @profileUrl = window.protocol.userProfileUrl

  profileRespChanged: (o, n) ->
    if @profileResp and @profileResp.code == 0
      window.profile = @profile = @profileResp.data