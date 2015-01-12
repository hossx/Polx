'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'tradingrecords-chart',
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
    Highcharts.setOptions
      colors: ["#4CAF50","#F44336"]
      chart:
        style:
          fontFamily: "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"

  createChart: () ->
    if @market and @records
      bought = []
      sold = []
      for record in @records
        if record.isSell
          sold.push [record.timestamp, record.price, record.quantity]
        else
          bought.push [record.timestamp, record.price, record.quantity]

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
            formatter: () -> @value
        tooltip:
          pointFormat: 'Quantity: {point.z}<br/>Price: {point.y}'
        plotOptions:
          area:
            marker:
              enabled: false
              symbol: 'circle'
              radius: 3
              states:
                hover:
                  enabled: true
  
        series: [{name: 'Taker Order: Buy', data: bought},{name: 'Taker Order: Sell', data: sold}]
