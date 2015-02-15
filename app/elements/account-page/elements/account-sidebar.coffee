'use strict'

Polymer 'account-sidebar',
  logout: () ->
    $.removeCookie('profile')
    @fire("user-logged-out")