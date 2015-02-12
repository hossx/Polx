'use strict'

Polymer 'no-record',
  msgMap:
    'en':
      hint: "No records"

    'zh':
      hint: "无记录"

  ready: () ->
    @M = @msgMap[window.lang]

  recordsChanged: (o, n) ->
    console.log("---")
    console.log(@records)