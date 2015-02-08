'use strict'

Polymer 'section-my-orders',
  msgMap:
    'en':
      yes: "YES"
      no: "NO"
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
      statuses:
        0: "Pending"
        1: "Filled"
        2: "Partial Filled"
        3: "Cancelled"

    'zh':
      yes: "决定取消"
      no: "先算了吧"
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
      statuses:
        0: "挂单中"
        1: "完全成交"
        2: "部分成交"
        3: "已经取消"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")

  cancelOrder: (e) ->
    @orderToCancel = (@orders.filter (o) -> o.id == e.target.getAttribute("orderid"))[0]
    console.log(@orderToCancel)
    this.$.confirmDialog.toggle()

  doCancelOrder: () ->
    console.debug("Canceling order: " + [@orderToCancel.id])
    work = () -> @go
    setTimeout(work, 500)