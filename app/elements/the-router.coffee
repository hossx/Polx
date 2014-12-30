'use strict'

Polymer 'the-router',
  ready: ()->
    @addEventListener 'network-error', (e) ->
      console.debug("network-error event seen: " + e.detail.url)
      this.$.errorToast.show()
