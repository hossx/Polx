'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'depth-chart',
  msgMap:
    'en':
      pointFormat: 'Quantity: {point.y:.8f}'
      buy: "Buy"
      sell: "Sell"

    'zh':
      pointFormat: '数量: {point.y:.8f}'
      buy: "买单"
      sell: "卖单"

  market: null
  width: 600
  height: 260
  regulate: true
  bids: []
  asks: []

  observe: {
    market: 'createChart'
    width: 'createChart'
    height:  'createChart'
    regulate:  'createChart'
    bids: 'createChart'
    asks: 'createChart'
  }

  ready: () ->
    @M = @msgMap[window.lang]
    Highcharts.setOptions
      colors: ["#4CAF50","#F44336"]
      chart:
        style:
          fontFamily: "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"

  createChart: () ->
    if @market and @asks and @bids
      asks = @asks
      bids = @bids.slice(0)
      # regulate asks and bids

      if @regulate
        while asks.length > 10 and bids.length > 10
          ratio = (asks[asks.length-1].price - asks[0].price)/ (bids[0].price - bids[bids.length-1].price)
          if ratio > 1.5
            asks = asks.slice(0, asks.length-1)
          else if ratio < 1/1.5
            bids = bids.slice(0, bids.length-1)
          else
            break

      asks = ([i.price, i.accumulated] for i in asks)
      bids = ([i.price, i.accumulated] for i in bids.reverse())

      chart = new Highcharts.Chart
        chart:
          renderTo: this.$.depthchart
          type: 'area'
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
            formatter: () -> @value
        yAxis:
          title:
            text: ""
          labels:
            formatter: () -> @value
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
  
        series: [{name: @M.buy, data: bids},{name: @M.sell, data: asks}]
