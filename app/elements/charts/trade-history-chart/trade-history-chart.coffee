'use strict'

# trades are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'trade-history-chart',
  market: null
  width: 600
  height: 260
  regulate: true
  trades: []

  observe: {
    market: 'createChart'
    width: 'createChart'
    height:  'createChart'
    trades: 'createChart'
  }

  ready: () ->
    @M = window.M['charts']['trades']
    Highcharts.setOptions
      colors: ["#ff8a65","#42bd41"]
      chart:
        style:
          fontFamily: window.config.chartFonts

  createChart: () ->
    if @market and @trades
      bought = []
      sold = []
      for record in @trades
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
