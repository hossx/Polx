'use strict'

Polymer 'cp-drawer-page',
  page: 0
  backlink: ''
  label: '' 
  icons: []

  switchTab: (e, detail, sender) -> 
    @page = sender.getAttribute("idx")
