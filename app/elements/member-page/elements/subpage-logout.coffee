'use strict'

Polymer 'subpage-logout',
  msgMap:
    'zh':
      logout: "登出"
      signedInAlready: "你已经用%s登录"
      gotoAccount: "查看账户"

    'en':
      logout: "Logout"
      signedInAlready: "You have logged in as %s already."
      gotoAccount: "Go to account"

  created: () ->
    @M = @msgMap[window.lang]
    if window.profile and window.profile.email
      @loggedInMessage = @M.signedInAlready.format(window.profile.email)


  logout: () ->
    @fire('user-request-logout')

