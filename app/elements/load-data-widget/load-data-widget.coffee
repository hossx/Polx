'use strict'

Polymer 'load-data-widget',
  msgMap:
    'en':
      empty: "No More Data"
      loadMore: "Load More"
    'zh':
      empty: "无更多数据"
      loadMore: "加载更多"

  ready: () ->
    @M = @msgMap[window.lang]
