'use strict'

Polymer 'cp-drawer-page',
  tab: 1
  backlink: ''
  label: '' 
  icons: []

  switchTab: (e, detail, sender) -> 
    @tab = sender.getAttribute("idx")
