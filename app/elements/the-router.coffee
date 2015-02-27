'use strict'

Polymer 'the-router',
  ready: ()->
    @setupEventListeners()

  created: () ->
    c = $.cookie('POLX_SESSION')
    if c
      console.debug(c)
      try
        window.profile = JSON.parse(c)
        @onUserLoggedIn()
      catch e
        window.profile = null
    
    if not window.profile
      console.log("No user logged in")

  stateChange: (e) ->
    path = e.detail.path
    if window.profile # logged in
      if path == '/member/login' or path == '/member/forgetpwd'
        e.preventDefault()
        this.$.router.go('/account')
      else if path == '/member/logged_out'
        e.preventDefault()
        this.$.router.go('/member/logout')
    else
      if path.indexOf('#/account') == 0
        e.stopPropagation()
        this.$.router.go('/member/login')
      else if path == '/member/logout'
        e.preventDefault()
        this.$.router.go('/member/logged_out')

  removeCookies: () ->
      $.removeCookie('POLX_SESSION')
      $.removeCookie('PLAY_SESSION', {domain: '.coinport.com'}) # this will fail due to httpOnly
      $.removeCookie('XSRF-TOKEN', {domain: '.coinport.com'})
      $.removeCookie('COINPORT_COOKIE_TIMESTAMP', {domain: '.coinport.com'})
      window.profile = null

  onUserLoggedIn: () ->
    console.debug("------user-logged-in: " + JSON.stringify(window.profile))
    z = window.$zopim
    if z
      z () -> 
        z.livechat.setName('U' + window.profile.uid)
        z.livechat.setNotes(JSON.stringify(window.profile))

    if location.hash == '#/member/login' or location.hash == '#/member/forgetpwd'
      this.$.router.go('/account')
    else if location.hash == '#/member/logged_out'
      this.$.router.go('/member/logout')

  onUserLogOut: () ->
    @removeCookies()
    z = window.$zopim
    if z
      z () ->
        z.livechat.setName('')
        z.livechat.endChat()


    console.debug("------user-logged-out")
    if location.hash == '#/member/logout'
      this.$.router.go('/member/logged_out')
    else if location.hash.indexOf('#/account') == 0
      this.$.router.go('/member/login') 
      

  setupEventListeners: () ->
    @addEventListener 'display-message', (e) ->
      if e.detail.error
        @error = e.detail.error
        this.$.errorToast.show()
      else if e.detail.warning
        @warning = e.detail.warning
        this.$.warningToast.show()
      else if e.detail.message
        @message = e.detail.message
        this.$.messageToast.show()

    @addEventListener 'user-logged-in', (e) ->
      @onUserLoggedIn()

    @addEventListener 'user-access-denied', (e) -> 
      console.debug("------user-access-denied")
      @onUserLogOut()

    @addEventListener 'user-request-logout', (e) -> 
      console.debug("------user-request-logout")
      this.$.logoutAjax.logout()
      @onUserLogOut()

    @addEventListener 'user-register-ok', (e) ->
      console.debug("------user-register-ok")
      if location.hash == '#/member/register'
        this.$.router.go('/member/check_email')

