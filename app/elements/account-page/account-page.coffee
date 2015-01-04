'use strict'

Polymer 'account-page',
  page: "assets"
  
  profileUrl: ''
  profileResp: null
  profile: null

  ready: () ->
    @profileUrl = window.protocol.userProfileUrl

  profileRespChanged: (o, n) ->
    if @profileResp and @profileResp.code == 0
      window.profile = @profile = @profileResp.data

