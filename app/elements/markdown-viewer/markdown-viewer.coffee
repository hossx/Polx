'use strict'

Polymer 'markdown-viewer',
  ready: () ->
    @file= ""
    @fileLang = ""
    @text = null
    @error = null
    @doclinks = []
    @files = []
    
  fileChanged: (o, n) ->
    if @file
      @fileLang = "%s_%s.md".format(@file, window.lang)
      
    doclinks = {}
    doclink = window.config.documents[@file]
    
    if doclink and doclink.tags
      for tag in doclink.tags 
        map = window.config.documentTagMap[tag]
        if map
          doclinks[k] = v for k, v of map
            

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