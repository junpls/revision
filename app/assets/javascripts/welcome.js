// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require jquery

const MAX_UPDATE_HEIGHT = 600

function updateFade() {
  $(".update").each(function() {
    console.log($(this, ".preview"))
    if ($(this).find(".preview").height() >= MAX_UPDATE_HEIGHT) {
      // $(this).find(".top_frame").addClass("top_fade")
      $(this).find(".bottom_frame").addClass("bottom_fade")
    }
  })
}

$(() => {
  updateFade()
})
