'use strict'

Polymer 'load-data-widget',
  msgMap:
    'en':
      noMore: "No More Data"
      loadMore: "Load More"
    'zh':
      noMore: "无更多数据"
      loadMore: "加载更多"

  ready: () ->
    @M = @msgMap[window.lang]

  loadMore: () ->
    @fire("load-more")