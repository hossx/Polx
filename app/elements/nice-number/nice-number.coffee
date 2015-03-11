'use strict'

Polymer 'nice-number',
  v: 0.0
  p: 8
  unit: ''
  x1: "0."
  x2: ""

  observe: {
    v: 'onChange'
    p: 'onChange'
  }
  onChange: () ->
    if @p
      pad = "00000000"
      p = Math.max(0, Math.min(@p, 8))
      fixed = @v.toFixed(p)
      x1 = fixed
      x1 = x1.slice(0, x1.length-1) while x1[x1.length-1] == '0' 
      @x1 = x1
      @x2 = pad.slice(0, fixed.length - @x1.length)

 fl: (v) ->v.toFixed(8)