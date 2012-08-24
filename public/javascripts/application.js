// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
$('#carousel').carouFredSel({
height: 140,
scroll: 1,
auto: true});
});
$("ul#topnav li").hover(function() { //Hover over event on list item
  $(this).css({ 'background' : '#1376c9 url(/images/topnav_active.gif) repeat-x'}); //Add background color and image on hovered list item
  $(this).find("span").show(); //Show the subnav
 },
 function() { //on hover out... 
  $(this).css({ 'background' : 'none'}); //Ditch the backgroun
  $(this).find("span").hide(); //Hide the subnav
 });
 $('a[data-popup]').live('click', function(e) {
 window.open($(this).href);
 e.preventDefault();
 });
