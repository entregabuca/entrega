(function($) {
  document.addEventListener("turbolinks:load", function greenOnCompleted() {
  	var orderStatus = $(".order-values-status").text()  
		if (orderStatus.includes('Completed')) {
		  $('div .earn').addClass('green')
		  
		}
	})
})(jQuery)