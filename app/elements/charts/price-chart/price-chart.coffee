'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'price-chart',
  market: null
  width: 600
  height: 260
  candles: []
  simple: false

  observe: {
    market: 'createChart'
    #width: 'createChart'
    height:  'createChart'
    candles: 'createChart'
    simple: 'createChart'
  }

  ready: () ->
    @M = window.M['charts']['price']
    Highcharts.setOptions
      chart:
        style:
          fontFamily: "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"

  createChart: () ->
    if @market and @candles.length > 0
      filtered = @candles.filter (x) -> x[5] > 0
      prices = ([i[0], i[1]] for i in filtered)

      chart = new Highcharts.Chart
        chart:
          renderTo: this.$.pricechart
          type: 'area'
          zoomType: 'xy'
          height: @height
          backgroundColor: null
          #width: @width
        colors: ["#ffeb3b"]
        legend:
          enabled: false
        credits:
          enabled: false
        title:
          enabled: false
          text: ''
        xAxis:
          allowDecimals: true
          title:
            enabled: false
          labels:
            enabled: not @simple
            formatter: () -> moment(@value).format("MM/DD-HH:mm")
        yAxis:
          title:
            enabled: false
          labels:
            enabled:  not @simple
            formatter: () -> @value
        tooltip:
          pointFormat: @M.pointFormat
        plotOptions:
          series:
            animation: false
          area:
            fillOpacity: 0.75
            marker:
              enabled: false
              symbol: 'circle'
              radius: 2
              states:
                hover:
                  enabled: true

        series: [{name: @M.price, data: prices}]
