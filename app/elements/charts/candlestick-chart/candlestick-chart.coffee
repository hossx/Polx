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
      groupingUnits = [['minute', [5,10,30]],['hour',[1,6,12]], ['day',[1]],['week',[1]],['year',null]]

      ohlc = ([item[0], item[1], item[2], item[3], item[4]] for item in @candles)
      volume = ([item[0], item[5]] for item in @candles)

      yAxis1 =
        labels:
          align: 'right'
          x: -3
        title:
          text: 'OHLC'
        height: '60%'
        lineWidth: 2

      yAxis2 =
        labels:
          align: 'right'
          x: -3
        title:
          text: 'Quantity'
        top: '65%'
        height: '35%'
        offset: 0
        lineWidth: 2

      serie1 = 
        type: 'candlestick'
        name: @market.id
        data: ohlc
        yAxis: 0
        dataGrouping:
          units: groupingUnits

      serie2 =
        type: 'column'
        name: 'Quantity'
        data: volume
        yAxis: 1
        dataGrouping:
          units: groupingUnits

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
        yAxis: [yAxis1, yAxis2]
        series: [serie1, serie2]
