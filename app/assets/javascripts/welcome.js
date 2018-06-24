// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require jquery

const MAX_COLLAPSED_HEIGHT = $(window).height() * 0.7;

function expandPreview(e) {
  let parent = $(e).closest(".update")
  let realHeight = parent.find(".insertionWrapper").outerHeight()
  parent.find(".preview").css({"max-height": realHeight+"px"})
  setExpandedMode(parent);
}

function setExpandedMode(e) {
  e.find(".preview").addClass("expandedPreview")
  e.find(".footerExpanded").addClass("expandedPreview")
  e.find(".footerLink").addClass("expandedPreview")
  e.find(".bottom_frame").removeClass("bottom_fade")
}

function updateFade() {
  $(".update").each(function() {
    let realHeight = $(this).find(".insertionWrapper").outerHeight()
      $(this).find(".preview").css({"max-height": MAX_COLLAPSED_HEIGHT+"px"})
    if (realHeight >= MAX_COLLAPSED_HEIGHT) {
      // $(this).find(".top_frame").addClass("top_fade")
      $(this).find(".bottom_frame").addClass("bottom_fade")
    } else {
      setExpandedMode($(this))
    }
  })
}

$(() => {
  updateFade()
})
