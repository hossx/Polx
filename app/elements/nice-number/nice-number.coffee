'use strict'

Polymer 'nice-number',
  v: 0.0

  vChanged: (o, n) ->
    pad = "00000000"
    fixed = @v.toFixed(8)
    part1 = fixed
    part1 = part1.slice(0, part1.length-1) while part1[part1.length-1] == '0' 
    @part1 = part1
    @part2 = pad.slice(0, fixed.length - @part1.length)
