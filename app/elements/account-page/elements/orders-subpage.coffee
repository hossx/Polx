'use strict'

Polymer 'orders-subpage',
  ready: () ->
    @M = window.M['account']['orders']
    @config = window.config

  formatTime: (t) ->
    moment(t).format('YYYY-MM/DD-hh:mm')

  loadMore: () ->
    this.$.ajax.loadMore()

  cancelOrder: (e) ->
    this.$.cancelOrderAjax.cancelOrder(e.target.getAttribute("orderId"))

  cancelledIdsChanged: (o, n) ->
    if @cancelledIds and @cancelledIds.length > 0
      @fire("display-message", {message: "Order (ID:%s) has been cancelled.".format(@cancelledIds[0])})
      for order in @orders
          if Number(order.id) in @cancelledIds
              order.status = 3
      @cancelledIds = null


  failedIdsChanged: (o, n) ->
    if @failedIds and @failedIds.length > 0
      @fire("display-message", {error: "Failed to cancel order (ID:%s).".format(@failedIds[0])})
      @failedIds = null

  statusLabel: (i) ->
    @M['statuses'][(i or 0).toString()]