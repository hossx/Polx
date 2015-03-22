'use strict'

Polymer 'data-subpage',
  ready: () ->
    @M = window.M['currency']['data']

  loadMoreTxs: () -> this.$.ajax1.loadMore()
  loadMoreSnapshots: () -> this.$.ajax2.loadMore()
  
  formatTime: (t) -> moment(t).format('YYYY/MM/DD-hh:mm')
  formatClass: (t) -> if t == 0 then 'withdraw' else 'deposit'

  opLabel: (i) -> @M['operationsLabel'][(i or 0).toString()]

  formatTxComment: (v) -> if @M then @M.formatTxComment.format(v) else ''
  formatSnapshotsComment: (v) -> if @M then @M.formatSsComment.format(v) else ''
