'use strict'

Polymer 'load-data-widget',
  msgMap:
    'en':
      empty: "No Data Available"
      noMore: "No More Data"
      loadMore: "Load More"
    'zh':
      empty: "无数据"
      noMore: "无更多数据"
      loadMore: "加载更多"

  ready: () ->
    @M = @msgMap[window.lang]
