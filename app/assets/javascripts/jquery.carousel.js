(function($) {
    $.fn.carousel = function() {
        var el = this;
        var lis = el.find('li');
        if (lis.length > 5) {
            for (var i = 5; i < lis.length; i++) {
                $(lis[i]).hide();
            };
        }
        $('.slider-right').live('click', function() {
            $(el).find('li:hidden:first').show();
            $(el).find('li:visible:first').hide();
        });
        $('.slider-left').live('click', function() {
            $(el).find('li:hidden:last').show();
            $(el).find('li:visible:last').hide();
        });
    }
})(jQuery);
