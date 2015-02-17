'use strict'

Polymer 'api-logout',
  logout: () -> 
    @url = '%s/api/v2/logout'.format(window.config.api.base)
    console.log(@url)
    @go
      