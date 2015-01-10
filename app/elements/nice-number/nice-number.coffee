'use strict'

Polymer 'nice-number',
  v: 0
  p: 10
  part1: ''
  part2: ''

  observe: {
    v: 'changed'
    precision: 'changed'
  }

  changed: (o, n) ->
    str =  String(@v)
    parts = str.split(".", 2)
    @part1 = parts[0]
    @part2 =
      if parts[1]
        (parts[1]+ "00000000000000000000").substring(0, @p)
      else
        "00000000000000000000".substring(0, @p)

    if parts[1] and parts[1].length > @p
      @tooltip = str
    else
      @tooltip = ''

