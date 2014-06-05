$(function(){

    var $window = $(window);
    var $body   = $(document.body);


    $body.scrollspy({
		target: '.sidebar'
    })

    $window.on('load', function () {
		$body.scrollspy('refresh');
    })

    $('.container [href=#]').click(function (e) {
		e.preventDefault()
    })
});
