'use strict'

Polymer 'home-page',
  ready: () ->
    @lang = window.lang
    @profile = window.profile
    if window.config.announcement
      @announceMsg = window.config.announcement.message
      @announceCritical = window.config.announcement.critical
      @announceLink = window.config.announcement.link
    @M = window.M['home']
    ###
    work = () =>
     
      $(this.$['branding']).backstretch([
         "/images/bg/bg-sea-1.jpg",
         "/images/bg/bg-sea-2.jpg"
        ],
        {duration: 10000, fade: 500})
      $(this.$['features']).backstretch('/images/home-page/banner-tablet-white.jpg');

    setTimeout(work, 5000)
    ###
    

