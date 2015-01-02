'use strict'

Polymer 'the-router',
  ready: ()->
    @setupEventListeners()
    @checkCookie()

  setupEventListeners: () ->
    @addEventListener 'network-error', (e) ->
      console.debug("network-error event seen: " + e.detail.url)
      @error = "Damn, I cannot connect to the servers :("
      this.$.toast.show()

    @addEventListener 'user-logged-out', (e) ->
      @checkCookie()

    @addEventListener 'user-logged-in', (e) ->
      @checkCookie()

  checkCookie: () ->
    sessionCookie = $.cookie("PLAY_SESSION")
    if not sessionCookie
      window.user = null
    else
      sessionData = JSON.parse(sessionCookie)
      window.user = {id: "fdaf", name: "fafda"}


