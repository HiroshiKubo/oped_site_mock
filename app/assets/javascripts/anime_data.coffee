# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.allCheckAnimeDataChecked = ->
  for data in $('input#animes_checked_checked')
    data.checked = true

window.allCheckAnimeDataDisChecked = ->
  for data in $('input#animes_checked_checked')
    data.checked = false