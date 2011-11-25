faq = {
	init : function() {
    $('div.faq .answer').toggle();
    $('div.faq .question').click(function() {
                    faq.toggle(this)
                });
	},


	toggle : function(elt) {
		$(elt).toggleClass('active');
		$(elt).siblings('.answer').slideToggle('fast');
    $(elt).children('.more').toggle();
	}
}

$(function() {
	faq.init();
});

