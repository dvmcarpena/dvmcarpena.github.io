/* ==========================================================================
   jQuery plugin settings and other scripts
   ========================================================================== */

var $nav = document.querySelector('#site-nav');
var $btn = document.querySelector('#site-nav button');
var $vlinks = document.querySelector('#site-nav .visible-links');
var $hlinks = document.querySelector('#site-nav .hidden-links');
var breaks = [];

function getWidth(el) {
   return parseFloat(getComputedStyle(el, null).width.replace("px", ""))
}

function updateNav() {
   var availableSpace = $btn.classList.contains('hidden') ? getWidth($nav) : getWidth($nav) - getWidth($btn) - 30;

   // The visible list is overflowing the nav
   if(getWidth($vlinks) > availableSpace) {
      // Record the width of the list
      breaks.push(getWidth($vlinks));

      // // Move item to the hidden list
      $hlinks.prepend($vlinks.removeChild($vlinks.children[$vlinks.children.length-1]))

      // // Show the dropdown btn
      if($btn.classList.contains('hidden')) {
         $btn.classList.remove('hidden');
      }

   // The visible list is not overflowing
   } else {
      // // There is space for another item in the nav
      if(availableSpace > breaks[breaks.length-1]) {

         // Move the item to the visible list
         $vlinks.appendChild($hlinks.removeChild($hlinks.children[0]))
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
   if(getWidth($vlinks) > availableSpace) {
      updateNav();
   }
}

document.addEventListener("DOMContentLoaded", function() {
   // Window listeners
   window.addEventListener("resize", updateNav);
   $btn.addEventListener('click', function() {
      $hlinks.classList.toggle('hidden');
      $btn.classList.toggle('close');
   });

   updateNav();

  // TODO smooth scroll better support
//   document.querySelector('a').addEventListener('click', function (e) {
//     e.preventDefault();
//     const target = e.target;
       // better check if target begins with #
//     if (target.classList.contains('js-inner-link')) {
//         const id = target.getAttribute('href').slice(1);
//         document.getElementById(id).scrollIntoView({ behavior: 'smooth' });
//     }
// });
});
