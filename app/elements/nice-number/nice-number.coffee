'use strict'

Polymer 'nice-number',
  v: 0
  p: 10

  observe: {
    v: 'changed'
    p: 'changed'
  }

  changed: (o, n) ->
    @formatted =  @v.toFixed(@p)
    if @v - @formatted != 0
      @tooltip = @v 
    else
      @tooltip = ''

