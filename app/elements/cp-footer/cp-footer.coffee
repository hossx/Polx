'use strict'

Polymer 'cp-footer',
  msgMap:
    'en':
      groups: [{
        label: "About"
        links: [{
          label: "Team"
          url: "/#/doc/team"
        }, {
          label: "Jobs"
          url: "/#/doc/jobs"
        }, {
          label: "Contact Us"
          url: "/#/doc/contactus"
        }]
      }, {
        label: "Legal"
        links: [{
          label: "Terms of Service"
          url: "/#/doc/tos"
        }, {
          label: "Privacy Polycies"
          url: "/#/doc/privacy"
        }, {
          label: "AML and KYC"
          url: "/#/doc/aml-kyc"
        }]
      }, {
        label: "Resources"
        links: [{
          label: "Bitcoin"
          url: ""
        }, {
          label: "API"
          url: "/#/doc/api2"
        }, {
          label: "Coinport PAY"
          url: "https://pay.coinport.com"
          class: "pay"
          tooltip: "Accept bitcoin payment for your business."
          target: "_blank"
        }]
      }, {
        label: "Social"
        links: [{
          label: "Twitter"
          url: "/#/tos"
        }, {
          label: "Facebook"
          url: "/#/privacy"
        }, {
          label: "Google+"
          url: "/#/aml"
        }]
      }]


    'zh':
      groups: [{
        label: "关于"
        links: [{
          label: "团队"
          url: "/#/doc/team"
        }, {
          label: "工作机会"
          url: "/#/doc/jobs"
        }, {
          label: "联系我们"
          url: "/#/doc/contactus"
        }]
      }, {
        label: "法律"
        links: [{
          label: "服务条款"
          url: "/#/doc/tos"
        }, {
          label: "隐私政策"
          url: "/#/doc/privacy"
        }, {
          label: "反洗钱"
          url: "/#/doc/aml-kyc"
        }]
      }, {
        label: "资源"
        links: [{
          label: "Bitcoin"
          url: ""
        }, {
          label: "API"
          url: "/#/doc/api2"
        }, {
          label: "币丰支付"
          url: "https://pay.coinport.com"
          class: "pay"
          tooltip: "币丰支付助力您的企业接收全球用户的比特币付款"
          target: "_blank"
        }]
      }, {
        label: "媒体"
        links: [{
          label: "Twitter"
          url: "/#/tos"
        }, {
          label: "Facebook"
          url: "/#/privacy"
        }, {
          label: "Google+"
          url: "/#/aml"
        }]
      }]

  ready: () ->
    @M = @msgMap[window.lang]

