'use strict'

Polymer 'member-page',
  ready: () ->
    console.log(this.$['wrapper'])
    $(this.$['page']).backstretch([
       "/images/bg-sea-1.jpg",
       "/images/bg-sea-2.jpg",
       "/images/bg-sea-3.jpg",
       "/images/bg-sea-4.jpg"
      ],
      {duration: 10000, fade: 750})