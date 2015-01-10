'use strict'

Polymer 'd3-depth-chart',
  width: 600
  height: 260
  padding: 40
  regulate: false
  bids: []
  asks: []

  observe: {
    width: 'createChart'
    height:  'createChart'
    padding:  'createChart'
    regulate:  'createChart'
    bids: 'createChart'
    asks: 'createChart'
  }

  createChart: () ->
    if @asks and @bids
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

      bids = bids.reverse()
      data = bids.concat(asks)

      svg = d3.select(this.$.depthgraph)

      width = parseInt(svg.style("width")) - 2 * @padding
      height = parseInt(svg.style("height")) - 2 * @padding
      x = d3.scale.linear().range([0, width])
      y = d3.scale.linear().range([height, 0])


      xAxis = d3.svg.axis().scale(x).orient("bottom").tickSize(-height, 0, 0)
      yAxis = d3.svg.axis().scale(y).orient("left").tickSize(-width, 0, 0)

      area = d3.svg.area()
        .x((d) -> x(d.price))
        .y0(height)
        .y1((d) -> y(d.accumulated))

      line = d3.svg.line()
        .x((d) -> x(d.price))
        .y((d) -> y(d.accumulated))

      svg = svg.append("g").attr("transform", "translate(" + @padding + "," + @padding + ")")
      
      x.domain(d3.extent(data, (d)->d.price))
      y.domain([0, d3.max(data, (d) ->d.accumulated)])

      svg.append("path").datum(bids).attr("class", "area-buy").attr("d", area)
      svg.append("path").datum(asks).attr("class", "area-sell").attr("d", area)
      svg.append("path").datum(bids).attr("class", "line-buy").attr("d", line)
      svg.append("path").datum(asks).attr("class", "line-sell").attr("d", line)

      svg.append("g").attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
        .append("text")
        .text("PRICE")
        .attr("class", "label")
        .attr("dx", (width+10) + "px")
 

      svg.append("g").attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .text("QUANTITY")
        .attr("class", "label")
        .attr("dy", "-10px")
