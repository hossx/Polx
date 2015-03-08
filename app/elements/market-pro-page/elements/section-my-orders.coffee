'use strict'

Polymer 'section-my-orders',
  msgMap:
    'en':
      yes: "YES"
      no: "NO"
      id: "ID"
      type: "Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Creation Time"
      buy: "Buy"
      sell: "Sell"
      status: "Status"
      cancelTip: "Cancel this order"
      cancelOrderDialogTitle: "Candel Order"
      cancelOrderDialogQuestion: "Do you really want to confirm this order?"
      noOrders: "No Orders"
      statuses:
        0: "Pending"
        1: "Partial Filled"
        2: "Filled"
        3: "Cancelled"

    'zh':
      yes: "取消订单"
      no: "先算了吧"
      id: "ID"
      type: "类型"
      price: "价格"
      quantity: "数量"
      total: "总金额"
      time: "下单时间"
      buy: "买入"
      sell: "卖出"
      cancelTip: "取消该订单"
      cancelOrderDialogTitle: "取消订单"
      cancelOrderDialogQuestion: "您真的要取消下面这个订单吗？"
      status: "状态"
      noOrders: "没有订单"
      statuses:
        0: "挂单中"
        1: "部分成交"
        2: "全部成交"
        3: "已经取消"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

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