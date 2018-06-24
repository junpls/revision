// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(() => {

  if (typeof revisions === 'undefined') return;

  function onTimeknotSelect(knot) {
    window.location.href = location.pathname+"?sha="+knot.sha;
  }

  const timelineWidth = $('.content').width() * .8;
  TimeKnots.draw("#timeline",
                 revisions, {
                   dateFormat: "%d %B",
                   color: "#696",
                   width: timelineWidth,
                   height: 100,
                   showLabels: true,
                   labelFormat: "%B %Y",
                   onKnotClick: onTimeknotSelect
                 });
});

