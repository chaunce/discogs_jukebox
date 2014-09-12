updateNowPlaying = ->
  $.ajax({ url: "/playlist/update_now_playing"; })
  setTimeout updateNowPlaying, 30000
  return
updatePlaylist = ->
  $.ajax({ url: "/playlist/update_playlist"; })
  setTimeout updatePlaylist, 10000
  return
$ ->
  setTimeout updateNowPlaying, 30000  if $("#now_playing").length > 0
  setTimeout updatePlaylist, 10000  if $("#playlist").length > 0
  return
