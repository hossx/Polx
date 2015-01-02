'use strict'

Polymer 'cp-drawer-page',
  tab: 0
  backlink: ''
  label = '' 
  ready: () ->
    @icons = []

  switchTab: (e, detail, sender) -> 
    @tab = sender.getAttribute("idx")
