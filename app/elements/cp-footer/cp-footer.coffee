'use strict'

Polymer 'cp-footer',
  msgMap:
    'en':
      groups: [
        label: "About"
        links: [
          label: "Contact Us"
          url: "/#/doc/contactus"
        ,
          label: "Fees"
          url: "/#/fees"
        ]
      ,
        label: "Legal"
        links: [
          label: "Terms of Service"
          url: "/#/doc/terms"
        ,
          label: "Privacy Polycies"
          url: "/#/doc/privacy"
        ,
          label: "AML and KYC"
          url: "/#/doc/aml-kyc"
        ]
      ,
        label: "Resources"
        links: [
          label: "API Spec"
          url: "/#/doc/api"
        ,
          label: "Coinport PAY"
          url: "https://pay.coinport.com"
          class: "pay"
          target: "_blank"
        ]
      ,
        label: "Social"
        links: [
          label: "Twitter"
          url: "http://twitter.com/coinportinc"
          target: "_blank"
        ,
          label: "Facebook"
          url: "http://facebook.com/coinport"
          target: "_blank"
        ]
      ]


    'zh':
      groups: [
        label: "关于"
        links: [
          label: "工作机会"
          url: "/#/doc/jobs"
        ,
          label: "联系我们"
          url: "/#/doc/contactus"
        ,
          label: "费用"
          url: "/#/fees"
        ]
      ,
        label: "法律"
        links: [
          label: "服务条款"
          url: "/#/doc/terms"
        ,
          label: "隐私政策"
          url: "/#/doc/privacy"
        ,
          label: "反洗钱与客户调查"
          url: "/#/doc/aml-kyc"
        ]
      ,
        label: "资源"
        links: [
          label: "API"
          url: "/#/doc/api"
        ,
          label: "通过Ripple网关充值"
          url: "/#/doc/ripple-deposit"
        ,
          label: "币丰支付"
          url: "https://pay.coinport.com"
          class: "pay"
          target: "_blank"
        ]
      ,
        label: "媒体"
        links: [
          label: "微博"
          url: "http://www.weibo.com/coinport"
          target: "_blank"
        ,
          label: "微信"
          url: 'weixin://contacts/profile/coinport'
          target: "_blank"
        ]
      ]

  ready: () ->
    @M = @msgMap[window.lang]

