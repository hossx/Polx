'use strict'

Polymer 'reserve-subpage',
  msgMap:
    'en':
      reserveDetails: 'Reserve Details'
      address: 'Address'
      balance: 'Balance'
      label: 'Type'
      signedMsg: "Signed Message"
      signature: "Signature"
      hot: "Hot"
      cold: "Cold"
      total: "Total"
      addresses: "addresses"

    'zh':
      reserveDetails: '准备金详情'
      address: '地址'
      balance: '余额'
      label: '类型'
      signedMsg: "被签名消息"
      signature: "签名"
      hot: "热钱包"
      cold: "冷钱包"
      total: "总量"
      addresses: '个地址'

  ready: () ->
    @M = @msgMap[window.lang]

  wiki: ''
  wikiLinted: ''
  details: null
  detailsUrl: ''

  currencyChanged: () ->
    @detailsUrl = window.protocol.reserveDetailsUrl(@currency.id)

  detailsChanged: (o, n) ->
    if @details
      #(TODO): @distribution = @details.data.distribution
      @distribution = @details.data.distribution.reduce (a, b) -> a.concat(b)
      @total = @total + i[1] for i in @distribution

  wikiChanged: (o, n) ->
    prefix = 'coinport:wiki\n'
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)
