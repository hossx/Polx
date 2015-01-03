'use strict'

Polymer 'profile-subpage',
  profile: null

  showGoogleAuthDialog: (e) ->
    this.$.googleAuthDialog.toggle()