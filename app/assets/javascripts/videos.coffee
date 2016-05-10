# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$ ->
#  $('.videos_list').click (e) ->
#    console.log e
#    console.log e.target

window.videosListClickCheckedChange = (num) ->
  video_checked = $('input#animes_checked_'+num)[0]

  console.log video_checked
  console.log video_checked.checked

  if video_checked.checked == true
    console.log "now_true"
    video_checked.checked = false
  else
    console.log "now_false"
    video_checked.checked = true

