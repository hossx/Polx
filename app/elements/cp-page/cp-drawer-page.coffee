'use strict'

Polymer 'cp-drawer-page',
  page: 0
  backlink: ''
  label: '' 
  buttons: []

  switchTab: (e, detail, sender) -> 
    @page = sender.getAttribute("idx")
