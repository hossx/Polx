'use strict'

Polymer 'nice-number',
  v: 0

  observe: {
    v: 'changed'
  }

  changed: (o, n) ->
    @formatted =  @v.toFixed(8)

