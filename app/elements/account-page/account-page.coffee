'use strict'

Polymer 'account-page',
  page: "assets"
  profile: null
  profileUrl: ''


  ready:() ->
    if window.profile
      @profile = window.profile
    else
      window.uid = "10000001"
      uid = window.uid
      @profileUrl = window.protocol.userProfileUrl(uid)
    

  profileChanged: (o, n) ->
    if @profile
      window.profile = @profile


