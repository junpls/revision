// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require jquery

const MAX_COLLAPSED_HEIGHT = Math.floor($(window).height() * 0.7)

function expandPreview(e) {
  let parent = $(e).closest(".update")
  let realHeight = parent.find(".insertionWrapper").outerHeight()
  parent.find(".preview").css({"max-height": realHeight+"px"})
  setExpandedMode(parent)
}

function setExpandedMode(e) {
  e.addClass("expandedPreview")
}

function updateFade() {
  $(".update").each(function() {
    let realHeight = $(this).find(".insertionWrapper").outerHeight()
    $(this).find(".preview").css({"max-height": MAX_COLLAPSED_HEIGHT+"px"})
    console.log(realHeight, MAX_COLLAPSED_HEIGHT);
    if (realHeight < MAX_COLLAPSED_HEIGHT) {
      setExpandedMode($(this))
    }
  })
}

window.addEventListener('load', function(){
  updateFade()
});