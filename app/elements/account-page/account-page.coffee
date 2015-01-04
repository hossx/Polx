'use strict'

Polymer 'account-page',
  page: "profile"
  profileResp: null
  profile: null
  profileUrl: ''


  ready:() ->
    if window.profile
      @profile = window.profile
    else
      window.uid = "10000001"
      uid = window.uid
      @profileUrl = window.protocol.userProfileUrl(uid)
    

  profileRespChanged: (o, n) ->
    if @profileResp and @profileResp.code == 0
      window.profile = @profile = @profileResp.data


