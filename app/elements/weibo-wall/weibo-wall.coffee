'use strict'

Polymer 'weibo-wall',
  width: 728
  height: 1200
  tags: "no-tag"

  tagsChanged: () ->
    @encodedTags = encodeURIComponent(@tags)
