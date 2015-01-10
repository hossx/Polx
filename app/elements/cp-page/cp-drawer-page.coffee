'use strict'

Polymer 'cp-drawer-page',
  page: 0
  backlink: ''
  label: '' 
  buttons: []

  switchPage: (e, detail, sender) -> 
    @page = sender.getAttribute("idx")
