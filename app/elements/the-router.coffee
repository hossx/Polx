'use strict'

Polymer 'the-router',
  userId: null
  sessionCookieName: 'PLAY_SESSION'

  ready: ()->
    @loginTestUrl = window.protocol.userProfileUrl
    @setupEventListeners()
    @checkLoginStatus()

  setupEventListeners: () ->
    @addEventListener 'network-error', (e) ->
      console.debug("network-error event seen: " + e.detail.url)
      @error = "Service is temporarily unavailable."
      this.$.toast.show()

    @addEventListener 'logout-attempted', (e) -> 
      $.removeCookie(@sessionCookieName)
      @userId = ''

    @addEventListener 'login-attempted', (e) ->
      @checkLoginStatus()

  checkLoginStatus: () ->
    sessionCookie = $.cookie(@sessionCookieName)
    if not sessionCookie
      @userId = '' 
    else
      console.debug("perform login status check using ajax")
      this.$.loginTestAjax.go()

  loginTestRespChanged: (o, n) ->
    console.debug(@loginTestResp)
    if @loginTestResp and @loginTestResp.data and @loginTestResp.data.uid
      @userId = @loginTestResp.data.uid
    else
      @userId = ''

  userIdChanged: (o, n) ->
    window.state.uid = @userId
    if @userId
      console.log("user logged in: " + @userId)
      this.$.router.go('/account') 
    else
      console.log("user logged out: " + o)
      this.$.router.go('/') 
    