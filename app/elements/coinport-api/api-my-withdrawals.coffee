'use strict'


Polymer 'api-my-withdrawals',
  currencyId: null
  cursor: 0
  limit: 50

  hasMore: false
  withdrawals: []

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
      @withdrawals = @data.withdrawals

  loadMore: () ->
    console.log("load more deposits...")

  updateUrl: () ->
    if @currencyId
      base = window.config.api.base
      limit = if @limit > 0 then @limit else 50
      url = '%s/api/v2/user/withdrawals?currency=%s&limit=%s'.format(base,@currencyId,limit)
      url = url + '%cursor=' + @cursor if @cursor > 0
      @url = url
