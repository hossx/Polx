'use strict'

Polymer 'account-sidebar',
  logout: () ->
    @fire("logout-requested")