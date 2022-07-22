$(document).ready(function () {
  'use strict';
  /* ========================================================================
     Fullscreen burger menu
   ========================================================================== */
  $(".menu-trigger, .mobilenav").click(function () {
    $(".mobilenav").fadeToggle(200);
  });
  $(".menu-trigger, .mobilenav").ready(function(){
   $(".mobilenav").bind('touchmove',function(){
     return false;
   });
  });

$('.learn-more').stop().on('click', function () {
    
     $(".test").bind('touchmove',function(){
       return false;
     });
});

$('.fade.in,.close').stop().on('click', function () {
    
      $(".test").unbind('touchmove');
});

  $(".menu-trigger, .mobilenav").click(function () {
    $(".menu-trigger").toggleClass("border-menu");
    $(".top-menu").toggleClass("top-animate");
    $(".mid-menu").toggleClass("mid-animate");
    $(".bottom-menu").toggleClass("bottom-animate");
  });
  /* ========================================================================
        pop-up fade
   ========================================================================== */

    $('#our-team').on('show.bs.modal', function (e) {
    $('.test').css('visibility', 'hidden');
    $('.test').animate({
      opacity: 0
    }, 10 ,'swing',function(){
      $('#our-team, .modal-backdrop ,body').css('background-color', '#081f33');
    });
  });
  $('#our-team').on('hide.bs.modal', function (e) {
    $('.test').css('visibility', 'visible');
    $('.test').animate({
      opacity: 1
    }, 300, 'swing' );
    $('#our-team , .modal-backdrop , body').css('background-color', '#003562');
  });


  /* ========================================================================
        pop-up center
   ========================================================================== */
$(function() {
    function reposition() {
        var modal = $(this),
            dialog = modal.find('.modal-dialog');
        modal.css('display', 'block');
        
        // Dividing by two centers the modal exactly, but dividing by three 
        // or four works better for larger screens.
        dialog.css("margin-top", Math.max(24, ($(window).height() - dialog.height()) / 2));
    }
    // Reposition when a modal is shown
    $('.modal').on('show.bs.modal', reposition);
    // Reposition when the window is resized
    $(window).on('resize', function() {
        $('.modal:visible').each(reposition);
    });
});

  /* ========================================================================
     pop-up menu z-index
   ========================================================================== */
  $('#our-team').on('show.bs.modal', function (e) {
    $('.menu-trigger, .menu-trigger-home').animate({
      opacity: 0
    }, 300 ,'swing',function(){
      $(this).css('display', 'none');
    });
  });
  $('#our-team').on('hide.bs.modal', function (e) {
    $('.menu-trigger, .menu-trigger-home').css('display', 'block');
    $('.menu-trigger, .menu-trigger-home').animate({
      opacity: 1
    }, 300, 'swing' );
  });

  /* ========================================================================
     Wow Animation
   ========================================================================== */
  var wow = new WOW({
    mobile: true
  });
  wow.init();
}); 
