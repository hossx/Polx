'use strict'

Polymer 'account-page',
  page: "deposit"
  
  profileUrl: ''
  profileResp: null
  profile: null
  currencyId: ""

  ready: () ->
    @profileUrl = window.protocol.userProfileUrl

  profileRespChanged: (o, n) ->
    if @profileResp and @profileResp.code == 0
      window.profile = @profile = @profileResp.data