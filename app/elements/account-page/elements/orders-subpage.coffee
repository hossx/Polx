'use strict'

Polymer 'orders-subpage',
  msgMap:
    'en':
      order: 'Orders'
      yes: 'YES'
      no: 'NO'
      id: 'ID'
      market: 'Market'
      type: 'Type'
      price: 'Price'
      quantity: 'Quantity'
      dealedQuantity: 'Dealed Quantity'
      total: 'Total'
      time: 'Creation Time'
      buy: 'Buy'
      sell: 'Sell'
      status: 'Status'
      cancelTip: 'Cancel this order'
      cancelOrderDialogTitle: 'Candel Order'
      cancelOrderDialogQuestion: 'Do you really want to confirm this order?'
      statuses:
        0: 'Pending'
        1: 'Partial Filled'
        2: 'Filled'
        3: 'Cancelled'

    'zh':
      orders: '我的订单'
      yes: '取消订单'
      no: '先算了吧'
      id: 'ID'
      market: '市场'
      type: '类型'
      price: '价格'
      quantity: '数量'
      dealedQuantity: '已成交数量'
      total: '总金额'
      time: '下单时间'
      buy: '买单'
      sell: '卖单'
      cancelTip: '取消该订单'
      cancelOrderDialogTitle: '取消订单'
      cancelOrderDialogQuestion: '您真的要取消下面这个订单吗？'
      status: '状态'
      statuses:
        0: '挂单中'
        1: '部分成交'
        2: '全部成交'
        3: '已经取消'

  ready: () ->
    @M = @msgMap[window.lang]
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
