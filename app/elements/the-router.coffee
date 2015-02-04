'use strict'

Polymer 'the-router',
  msgMap:
    'en':
      serviceUnavailable: "Service is temporarily unavailable."

    'zh':
     serviceUnavailable: "币丰港服务暂时不可用。是不是你的网络有问题啦？"

  userId: null # null indicates initial state
  sessionCookieName: 'PLAY_SESSION'

  ready: ()->
    @M = @msgMap[window.lang]
    window.state.uid = null
    @loginTestUrl = window.protocol.userProfileUrl
    @setupEventListeners()
    @checkLoginStatus()

  setupEventListeners: () ->
    @addEventListener 'network-error', (e) ->
      console.debug("network-error event seen: " + e.detail.url)
      @error = @M.serviceUnavailable
      this.$.toast.show()

    @addEventListener 'logout-requested', (e) -> 
      $.removeCookie(@sessionCookieName)
      @userId = ''

    @addEventListener 'api-access-error', (e) ->
      $.removeCookie(@sessionCookieName)
      @userId = ''

    @addEventListener 'login-checked', (e) ->
      @userId = e.detail.uid

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
    if @user == null #special
      window.state.uid = null
      console.error("not supposed to see this")
    else if @userId == ''
      window.state.uid = null
      console.log("user logged out: " + o)
      if location.hash.indexOf('#/account') == 0 or location.hash == '#/member/signout'
        this.$.router.go('/member/signedout') 
    else
      window.state.uid = @userId
      console.log("user logged in: " + @userId)
      if location.hash.indexOf('#/member') == 0
        this.$.router.go('/account') 
