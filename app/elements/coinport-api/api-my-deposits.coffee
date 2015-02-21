'use strict'

Polymer 'api-my-deposits',
  currencyId: ''
  limit: 50
  cursor: 0

  hasMore: false
  deposits: []

  observe:
    currencyId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  created: () ->
    @updateUrl()

  onChange: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      @deposits = @data.deposits

  loadMore: () ->
    console.log("load more deposits...")

  updateUrl: () ->
    if @currencyId
      limit = if @limit > 0 then @limit else 50
      url = '%s/api/v2/user/deposits?currency=%s&limit=%s'.format(@base(),@currencyId,limit)
      url = url + '&cursor=' + @cursor if @cursor > 0
      @url = url

