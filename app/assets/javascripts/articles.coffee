# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.a8ToData= () ->
  ad = []
  for i in [0..2]
    ad[i] = $('#advertisement_'+(i+1))[0].value

  ad_json = JSON.stringify(ad)
  console.log ad[0]
  console.log ad[1]
  console.log ad[2]
  console.log ad_json
  $('#article_advertisement')[0].value = ad_json