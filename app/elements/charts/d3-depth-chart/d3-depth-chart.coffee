'use strict'

Polymer 'd3-depth-chart',
  width: 600
  height: 260
  padding: 40
  bids: []
  asks: []

  observe: {
    bids: 'createChart'
    asks: 'createChart'
  }

  createChart: () ->
    if @asks and @bids
      console.log("===")
      asks = @asks
      bids = []
      bids.push @bids...
      bids.reverse()
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
        .text("Price")
        .attr("class", "label")
        .attr("dx", (width + 10) + "px")
 

      svg.append("g").attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .text("Quantity")
        .attr("class", "label")
        .attr("y", (-height -20) + "px")
