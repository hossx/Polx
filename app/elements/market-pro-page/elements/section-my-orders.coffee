'use strict'

Polymer 'section-my-orders',
  ready: () ->
    @M = window.M['market-pro']['my-orders']

  go: () ->
    this.$.ajax.go()

  formatTime: (t) -> moment(t).format("MM/DD-hh:mm:ss")
  formatStatus: (i) -> if @M then @M['statuses'][(i or 0).toString()] else ''

  cancelOrder: (e) ->
    @orderToCancel = (@orders.filter (o) -> o.id == e.target.getAttribute("orderid"))[0]
    this.$.confirmDialog.toggle()

  doCancelOrder: () ->
    console.debug("Canceling order: " + @orderToCancel.id)
    this.$.cancelOrderAjax.cancelOrder(@orderToCancel.id)

  cancelledIdsChanged: (o, n) ->
    if @cancelledIds and @cancelledIds.length > 0
      @fire("display-message", {message: "Order (ID:%s) has been cancelled.".format(@cancelledIds[0])})
      @cancelledIds = null
      @fire('refresh-market-data') 

  failedIdsChanged: (o, n) ->
    if @failedIds and @failedIds.length > 0
      @fire("display-message", {error: "Failed to cancel order (ID:%s).".format(@failedIds[0])})
      @failedIds = null