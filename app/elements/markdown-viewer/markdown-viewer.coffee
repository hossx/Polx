'use strict'

Polymer 'markdown-viewer',
  ready: () ->
    @file= ""
    @text = null
    @error = null
    @doclinks = []
    @files = []
    
  fileChanged: (o, n) ->
    doclinks = {}
    for tag in window.config.documents[@file].tags
      for k, v of window.config.documentTagMap[tag]
        doclinks[k] = v

    @doclinks = doclinks
    @files = Object.keys(@doclinks)

  handleResponse: (o, n) ->
    console.warn("not found doc " + @file + " " +  @text)

  errorChanged: (o, n) ->
    console.warn("error: " + @error)

  onError: (event) ->
    console.log("error occured")

  textChanged: (o, n) ->
    setTimeout () =>
      this.$.marked.style.opacity = 1
      #this.$.footer.addClass("show")
    ,10