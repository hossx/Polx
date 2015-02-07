'use strict'

Polymer 'candlestick-chart',
  market: null
  width: 600
  height: 260
  candles: []
  oneyear: 356*24*3600*1000

  observe: {
    market: 'createChart'
    width: 'createChart'
    height:  'createChart'
    candles: 'createChart'
  }

  createChart: () ->
    if @market and @candles.length > 0
      groupingUnits = [['minute', [5,10,30]],['hour',[1,6,12]], ['day',[1]],['week',[1]],['year',null]]

      filtered = @candles.filter (i) -> i[5] > 0
      ohlc = ([item[0], item[1], item[2], item[3], item[4]] for item in filtered)
      volume = ([item[0], item[5]] for item in filtered)

      for v in volume
        x = moment(v[0]).format("MM/DD-HH:mm")

      yAxis1 =
        labels:
          align: 'right'
          formatter: () -> if @value < 1 then @value.toFixed(8) else @value
          x: -3
        title:
          text: 'OHLC'
        height: '80%'
        lineWidth: 0
        gridLineWidth: 0
        tickLength: 0

      yAxis2 =
        labels:
          align: 'right'
          formatter: () -> @value
          x: -3
        title:
          text: 'Quantity'
        top: '80%'
        height: '20%'
        offset: 0
        lineWidth: 0
        gridLineWidth: 0
        tickLength: 0

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
          backgroundColor: null
        colors: ["#0a8f08", "#9e9e9e"]
        credits:
          enabled: false
        title:
          text: ''
        rangeSelector:
          selected: 1
        yAxis: [yAxis1, yAxis2]
        series: [serie1, serie2]
