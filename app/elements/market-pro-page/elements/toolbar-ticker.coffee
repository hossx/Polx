'use strict'

Polymer 'toolbar-ticker',
  msgMap:
    'en':
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"

    'zh':
      lastPrice: "最新成交价"
      volume: "24小时成交"
      change: "24小时价差"

  ready: () ->
    @M = @msgMap[window.lang]