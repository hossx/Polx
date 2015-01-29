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

    'zh':
      reserveDetails: '准备金详情'
      address: '地址'
      balance: '余额'
      label: '类型'
      signedMsg: "被签名消息"
      signature: "签名"
      hot: "热钱包"
      cold: "冷钱包"

  ready: () ->
    @M = @msgMap[window.lang]

  wiki: ''
  wikiLinted: ''
  details: null
  detailsUrl: ''

  currencyChanged: () ->
    @detailsUrl = window.protocol.reserveDetailsUrl(@currency.id)

  detailsChanged: (o, n) ->

  wikiChanged: (o, n) ->
    prefix = 'coinport:wiki\n'
    if @wiki and @wiki.indexOf(prefix) == 0
      @wikiLinted = @wiki.substring(prefix.length)
