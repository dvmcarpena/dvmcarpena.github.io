/* ==========================================================================
   jQuery plugin settings and other scripts
   ========================================================================== */

var $nav = document.querySelector('#site-nav');
var $btn = document.querySelector('#site-nav button');
var $vlinks = document.querySelector('#site-nav .visible-links');
var $hlinks = document.querySelector('#site-nav .hidden-links');
var breaks = [];

function closeNav() {
   $hlinks.classList.toggle('hidden');
   $btn.classList.toggle('close');
}

function getWidth(el) {
   return parseFloat(getComputedStyle(el, null).width.replace("px", ""))
}

function updateNav() {
   var availableSpace = $btn.classList.contains('hidden') ? getWidth($nav) : getWidth($nav) - getWidth($btn) - 30;

   // The visible list is overflowing the nav
   if(getWidth($vlinks) > availableSpace && $vlinks.children.length > 1) {
      // Record the width of the list
      breaks.push(getWidth($vlinks));

      // // Move item to the hidden list
      var t = $vlinks.removeChild($vlinks.children[$vlinks.children.length-1])
      $hlinks.prepend(t)
      t.addEventListener('click', closeNav)

      // // Show the dropdown btn
      if($btn.classList.contains('hidden')) {
         $btn.classList.remove('hidden');
      }

   // The visible list is not overflowing
   } else {
      // // There is space for another item in the nav
      if(availableSpace > breaks[breaks.length-1]) {

         // Move the item to the visible list
         var t = $hlinks.removeChild($hlinks.children[0])
         $vlinks.appendChild(t)
         t.removeEventListener('click', closeNav)
         breaks.pop();
      }

      // // Hide the dropdown btn if hidden list is empty
      if(breaks.length < 1) {
         $btn.classList.add('hidden');
         $btn.classList.remove('close');
         $hlinks.classList.add('hidden');
      }
   }

   // Keep counter updated
   $btn.setAttribute("count", breaks.length);

   // Recur if the visible list is still overflowing the nav
   if(getWidth($vlinks) > availableSpace && $vlinks.children.length > 1) {
      updateNav();
   }
}

document.addEventListener("DOMContentLoaded", function() {
   // Window listeners
   window.addEventListener("resize", updateNav);
   $btn.addEventListener('click', closeNav);
   for (i = 0; i < $hlinks.children.length; i++) {
      $hlinks.children[i].addEventListener('click', closeNav)
   }

   // Init
   updateNav();
});

// function isPwa() {
//    var displayModes = ["fullscreen", "standalone", "minimal-ui"];
//    return displayModes.some(
//        (displayMode) => window.matchMedia('(display-mode: ' + displayMode + ')').matches
//    ); 
// }

// if (isPwa()) {
//    console.log("PWA mode on")
//    if('serviceWorker' in navigator) {
//        navigator.serviceWorker.register('./assets/js/pwa.min.js');
//    };
// }

// if ('serviceWorker' in navigator) {
//    navigator.serviceWorker.register('/sw.js');
// }
