'use strict'

Polymer 'cp-drawer-page',
  tab: 0

  switchTab: (e, detail, sender) -> 
    @tab = sender.getAttribute("idx")
