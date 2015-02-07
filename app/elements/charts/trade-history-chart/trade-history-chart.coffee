'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'trade-history-chart',
  msgMap:
    'en':
      pointFormat: 'Quantity: {point.z}<br/>Price: {point.y}'
      takerOrderTypeBuy: "Taker: Buy"
      takerOrderTypeSell: "Taker: Sell"

    'zh':
      pointFormat: '数量: {point.z}<br/>价格: {point.y}'
      takerOrderTypeBuy: "触发单类型: 买单"
      takerOrderTypeSell: "触发单类型: 卖单"


  market: null
  width: 600
  height: 260
  regulate: true
  records: []

  observe: {
    market: 'createChart'
    width: 'createChart'
    height:  'createChart'
    records: 'createChart'
  }

  ready: () ->
    @M = @msgMap[window.lang]
    Highcharts.setOptions
      colors: ["#ff5722","#0a8f08"]
      chart:
        style:
          fontFamily: "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"

  createChart: () ->
    if @market and @records
      bought = []
      sold = []
      for record in @records
        if record.isSell
          sold.push [record.timestamp, record.price, record.amount]
        else
          bought.push [record.timestamp, record.price, record.amount]

      chart = new Highcharts.Chart
        chart:
          renderTo: this.$.tradingrecords
          type: 'bubble', 
          zoomType: 'xy'
          height: @height
          width: @width
        credits:
          enabled: false
        title:
          text: ''
        xAxis:
          allowDecimals: true
          labels:
            formatter: () -> moment(@value).format("MM/DD-HH:mm")
        yAxis:
          title:
            text: ""
          labels:
            formatter: () -> @value.toFixed(8)
        tooltip:
          pointFormat: @M.pointFormat
        plotOptions:
          area:
            marker:
              enabled: false
              symbol: 'circle'
              radius: 3
              states:
                hover:
                  enabled: true
  
        series: [{name: @M.takerOrderTypeBuy, data: bought},{name: @M.takerOrderTypeSell, data: sold}]
