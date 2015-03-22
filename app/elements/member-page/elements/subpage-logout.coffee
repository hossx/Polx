'use strict'

Polymer 'subpage-logout',
  created: () ->
    @M = window.M['member']['logout']
    if window.profile and window.profile.email
      @loggedInMessage = @M.signedInAlready.format(window.profile.email)


  logout: () ->
    @fire('user-request-logout')

