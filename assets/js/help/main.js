var validUser = false;

// SVG to PNG fallback
if(!Modernizr.svg) {
    $('img[src*="svg"]').attr('src', function() {
        return $(this).attr('src').replace('.svg', '.png');
    });
}

// When document ready
(function($) {
    $(document).ready(function() {
        var formStartAt;

        $('#contact-form').on('shown.bs.modal', function () {
            $('#contact-form-name').focus()
            formStartAt = new Date();
        });

        $(".list-links ul").not(":has(li)").remove();

        // Site navigation open states
        $('.site--header .menu-toggle').click(function(event) {
            $(this).parent().parent().toggleClass('menu-open').addClass('js-open');
            $(this).next('.header--nav').stop(false,true).slideToggle(350);
            var once = true;

            $(this).next('.nav-menu').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
                                          function(e) {
                                              if(once)
                                                  console.log('Transition complete!  This is the callback, no library needed!');
                                              once = false;
                                          });
            return false;
        });

        $(".js_tinynav").tinyNav();

        // expand parents and children of active category
        var activeCat = $(".js_tinynav li.active")
        activeCat.parentsUntil(".js_tinynav", "ul").addClass("in").siblings().removeClass("collapsed");
        activeCat.find("ul.collapse").addClass("in")
        activeCat.find("a.have_drop").removeClass("collapsed")

        $('#contactForm').find('input').focus(function() {
            validUser = true;
        });

        $('#contactForm').on('submit', function(){
            $('#ft').val(((new Date() - formStartAt) / 1000).toFixed(0))
        });

        $("table").addClass("table table-bordered");

        $("#contact-form .checkbox.required input[type=checkbox]").change(function(){
            var $checkboxes = $("#contact-form .checkbox.required input[type=checkbox]"),
                $this = $(this),
                errMsg = $(this).is(':checked') ? '' : 'Select at least one';

            $checkboxes.each(function(){
                this.setCustomValidity(errMsg);
            });
        }).each(function(){
            this.setCustomValidity('Select at least one');
        });

        //Add Filtered Search Results
        var delay = (function(){ 
            var timer = 0;
            return function(callback, ms){
                clearTimeout (timer);
                timer = setTimeout(callback, ms);
            };
        })();
        var prevSearch = "";
        $(".search-form").append('<ul class="search-results"></ul>');
        $(".search_input").attr("autocomplete", "off");
         
        // Add a unique id to each image
        var setImageId = function(element, index) {
            element.setAttribute('id', "docImg_" + index);
        };

        var forEach = function (array, callback, scope) {
            for (var i = 0; i < array.length; i++) {
                callback.call(scope, i, array[i]); // passes back stuff we need
            }
        };

        var bindLightBoxClickEvent = function(element){
            element.addEventListener('click', function(e) {
                showLightBox(e.target.id.split("docImg_").pop(), articleImagesElements);
            }) 
        }

        var articleImagesElements = document.querySelectorAll(".article-body img");
        forEach(articleImagesElements, function (index, value) {
            setImageId(value, index);
        });

        forEach(articleImagesElements, function (index, value) {
            if (value.parentElement.tagName != "A") {
                bindLightBoxClickEvent(value)
            }
        });
    });
}(jQuery))

function checkValidUser() {
    if (validUser) {
        jQuery('#contactForm').attr('action', window.baseURL + '/contact');
    }
}

function showLightBox(startAtIndex, imgs) {
    // get lightbox container
    var pswpElement = document.querySelectorAll('.pswp')[0];
    
    // build items array
    var items = [];

    // get all images on page
    // var imgs = document.getElementsByTagName("img");

    for (var i = 0; i < imgs.length; i++) {
        var photo = {
            src: imgs[i].src,
            w: parseInt(imgs[i].naturalWidth, 10),
            h: parseInt(imgs[i].naturalHeight, 10)
        }

        items.push(photo)
    }

    // define options (if needed)
    var options = {
        index: parseInt(startAtIndex, 10), // Slide to start on.
        bgOpacity: 0.8,
        shareEl: false
    };

    // Initializes and opens PhotoSwipe
    var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
    gallery.init();
}
