'use strict'

Polymer 'nice-number',
  v: 0.0

  vChanged: (o, n) ->
    pad = "00000000"
    fixed = @v.toFixed(8)
    @part1 = fixed.match(/(?=.*?\.)(.*?[1-9])(?!.*?\.)(?=0*$)|^.*$/)[0]
    @part2 = pad.slice(0, fixed.length - @part1.length)
