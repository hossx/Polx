'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'depth-chart',
  market: null
  width: 600
  height: 260
  regulate: true
  bids: []
  asks: []
  simple: false

  observe: {
    market: 'createChart'
    #width: 'createChart'
    height:  'createChart'
    regulate:  'createChart'
    bids: 'createChart'
    asks: 'createChart'
    simple: 'createChart'
  }

  ready: () ->
    @M = window.M['charts']['depth']
    Highcharts.setOptions
      chart:
        style:
          fontFamily: window.config.chartFonts

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
          backgroundColor: null
          #width: @width
        colors: ["#42bd41","#ff8a65"]
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
            formatter: () -> if @value < 1 then @value.toFixed(8) else @value
        yAxis:
          allowDecimals: true
          title:
            enabled: false
          labels:
            enabled:  not @simple
            formatter: () -> if @value < 1 then @value.toFixed(8) else @value
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
  
        series: [{name: @M.buy, data: bids},{name: @M.sell, data: asks}]
