'use strict'

Polymer 'candlestick-chart',
  market: null
  width: 600
  height: 260
  candles: []

  observe: {
    market: 'createChart'
    width: 'createChart'
    height:  'createChart'
    candles: 'createChart'
  }

  createChart: () ->
    if @market and @candles
      groupingUnits = [['week',[1]],['month', [1 ,2 ,3, 4 ,6]]]

      ohlc = ([item[0], item[1], item[2], item[3], item[4]] for item in @candles)
      volume = ([item[0], item[5]] for item in @candles)

      chart = new Highcharts.StockChart
        chart:
          renderTo: this.$.candlesticks
          height: @height
          width: @width
        credits:
          enabled: false
        title:
          text: ''
        rangeSelector:
          selected: 1
        yAxis: [{
          labels:
            align: 'right'
            x: -3
          title:
            text: 'OHLC'
          height: '60%'
          lineWidth: 2
        },{
          labels:
            align: 'right'
            x: -3
          title:
            text: 'Volume'
          top: '65%'
          height: '35%'
          offset: 0
          lineWidth: 2
        }]
        series: [{
          type: 'candlestick'
          name: @market.id
          data: ohlc
          dataGrouping:
            units: groupingUnits
            
        },{
          type: 'column'
          name: 'Volume'
          data: volume
          yAxis: 1
          dataGrouping:
            units: groupingUnits
        }]
