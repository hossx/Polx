'use strict'

Polymer 'the-router',
  userLoggedIn: false

  ready: ()->
    @setupEventListeners()

    c = $.cookie('profile')
    if c
      profile = JSON.parse(c)
      window.profile = profile
      @fire("user-logged-in")

  stateChange: (e) ->
    path = e.detail.path
    if @userLoggedIn
      if path == '/member/login' or path == '/member/forgetpwd'
        e.preventDefault()
        this.$.router.go('/account')
    else
      if path.indexOf('#/account') == 0
        e.preventDefault()
        this.$.router.go('/member/login')
      else if path == '/member/logout'
        e.preventDefault()
        this.$.router.go('/member/logged_out')

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

    @addEventListener 'user-request-logout', (e) -> 
      console.debug("------user-request-logout: " + JSON.stringify(window.profile))
      $.removeCookie('profile')
      $.removeCookie('PLAY_SESSION', {domain: '.coinport.com'}) # this will fail due to httpOnly
      $.removeCookie('XSRF-TOKEN', {domain: '.coinport.com'})
      $.removeCookie('COINPORT_COOKIE_TIMESTAMP', {domain: '.coinport.com'})
      @fire('user-logged-out')

    @addEventListener 'user-logged-in', (e) -> 
      console.debug("------user-logged-in: " + JSON.stringify(window.profile))
      @userLoggedIn = true

      if location.hash == '#/member/login' or location.hash == '#/member/forgetpwd'
        this.$.router.go('/account')

    @addEventListener 'user-logged-out', (e) -> 
      console.debug("------user-logged-out")
      window.profile = null
      @userLoggedIn = false

      if location.hash == '#/member/logout'
        this.$.router.go('/member/logged_out')
      else if location.hash.indexOf('#/account') == 0
        this.$.router.go('/member/login') 
        

