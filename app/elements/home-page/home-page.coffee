'use strict'

Polymer 'home-page',
  msgMap:
    'en':
      about: "About"
      reserves: "Reserve"
      history: "Data"
    'zh':
      about: "货币趋势"
      reserves: "准备金数"
      history: "历史数据"


  ready: () ->
    @M = @msgMap[window.lang]

    $(this.$['branding']).backstretch("http://league.life/wp-content/themes/pressotheme-5_3_1_child/images/section_bg/home_banner.jpg")

