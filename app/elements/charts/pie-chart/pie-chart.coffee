'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'pie-chart',
  observe: {
    width: 'createChart'
    height: 'createChart'
    data: 'createChart'
    colors: 'createChart'
  }

  ready: () ->
    @M = window.M['charts']['pie']
    Highcharts.setOptions
      chart:
        style:
          fontFamily: "'Roboto Condensed','Lantinghei SC','Hiragino Sans GB','Microsoft Yahei',sans-serif"
    @createChart()

  createChart: () ->
    if @width and @height and @colors and @data and @data.length > 0
      chart = new Highcharts.Chart
        chart:
          renderTo: this.$.piechart
          width: @width
          height: @height
          backgroundColor: null
        colors: @colors
        legend:
          enabled: false
        credits:
          enabled: false
        title:
          enabled: false
          text: ''
        plotOptions:
          pie:
            allowPointSelect: true
            cursor: 'pointer'
            dataLabels:
              enabled: false
            showInLegend: true
        tooltip:
          pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        series:[
           type: 'pie'
           name: @M.reserve
           data: @data
        ]
