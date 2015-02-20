'use strict';

Polymer 'api-my-profile',
  created: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    @profile = @data if @data

  updateUrl: () ->
    @url = "%s/api/v2/user/profile".format(@base())
