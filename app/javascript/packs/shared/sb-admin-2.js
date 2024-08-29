$(document).on('turbolinks:load', function() {
  function load_and_close() {
    if ($(window).width() < 768) {
      $('.sidebar .collapse').removeClass('show');
    } else {
      $('.sidebar .collapse').removeClass('show');
    };

    if ($(window).width() < 576) {
      $("#accordionSidebar").addClass("toggled");
      $("body").addClass("sidebar-toggled");
    } else {
      $('#accordionSidebar').removeClass('toggled');
    }
  }

  load_and_close()
  // Toggle the side navigation
  $("#sidebarToggle, #sidebarToggleTop").on('click', function(e) {
    $("body").toggleClass("sidebar-toggled");
    $(".sidebar").toggleClass("toggled");
    if ($(".sidebar").hasClass("toggled")) {
      $(".sidebar").addClass("d-none")
      $('.sidebar .collapse').remoaddveClass('show');
    }
    else {
      $(".sidebar").removeClass("d-none")
      $('.sidebar .collapse').removeClass('show');
    };
  });

  $(".nav.nav-tabs").on('click', function(e) {
    $(".nav.nav-tabs .nav-link").removeClass('active');

    // $(e).addClass('active');
  });

  // Close any open menu accordions when window is resized below 768px
  $(window).resize(function() {
    load_and_close()
  });

  // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
  $('body.fixed-nav .sidebar').on('mousewheel DOMMouseScroll wheel', function(e) {
    if ($(window).width() > 768) {
      var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
      this.scrollTop += (delta < 0 ? 1 : -1) * 30;
      e.preventDefault();
    }
  });

  // Scroll to top button appear
  $(document).on('scroll', function() {
    var scrollDistance = $(this).scrollTop();
    if (scrollDistance > 100) {
      $('.scroll-to-top').fadeIn();
    } else {
      $('.scroll-to-top').fadeOut();
    }
  });

  // Smooth scrolling using jQuery easing
  $(document).on('click', 'a.scroll-to-top', function(e) {
    var $anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: ($($anchor.attr('href')).offset().top)
    }, 1000, 'easeInOutExpo');
    e.preventDefault();
  });
})
