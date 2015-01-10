'use strict'

Polymer 'nice-number',
  v: 0
  p: 10

  observe: {
    v: 'changed'
    p: 'changed'
  }

  changed: (o, n) ->
    @formatted =  ("%" + @p + "f").format(@v)

    if parseFloat(@formatted) != @v
      @tooltip = @v 
    else
      @tooltip = ''

