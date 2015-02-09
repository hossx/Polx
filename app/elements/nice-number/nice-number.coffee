'use strict'

Polymer 'nice-number',
  v: 0.0
  p: 8
  unit: ''
  part1: "0."
  part2: ""

  observe: {
    v: 'onChange'
    p: 'onChange'
  }
  onChange: () ->
    if @v and @p
      pad = "00000000"
      p = Math.max(0, Math.min(@p, 8))
      fixed = @v.toFixed(p)
      part1 = fixed
      part1 = part1.slice(0, part1.length-1) while part1[part1.length-1] == '0' 
      @part1 = part1
      @part2 = pad.slice(0, fixed.length - @part1.length)
