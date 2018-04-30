// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var kurbickFilms = [{name:"Day of the Fight", date: "1951-04-26"},
  {name:"The Seafarers", 	date:"1953-10-15"},
  {name:"Lolita (1962 film)", 	date:"1962-06-13"},
  {name:"Fear and Desire", date:	"1953-03-31"},
  {name:"Paths of Glory", date:	"1957-12-25"},
  {name:"A Clockwork Orange (film)", date:	"1971-12-19"},
  {name:"Killer's Kiss", date:	"1955-09-28"}];

$(() => {
  const timelineWidth = $(window).width() * .8;
  TimeKnots.draw("#timeline",
                 kurbickFilms, {
                   dateFormat: "%d %B",
                   color: "#696",
                   width: timelineWidth,
                   height: 100,
                   showLabels: true,
                   labelFormat: "%B %Y"
                 });
});

