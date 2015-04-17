$(function() {
	updateTotalAmount();
	$('.add_cart').on("click", function(event) {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : $(this).attr('href'),
			success : function(response) {
				if (response.result == "success") {
					window.location = '/cart';
					alert("Product added successfully!");
				} else {
					$("#addCartStatus").html(response.message);
				}
			},
			error : function(data) {
				$("#addCartStatus").html("Something went wrong");
			}
		});
	});
	
	function updateTotalAmount() {
		var elements = $(".total_price");
		total = 0;
		for (i=0;i<elements.length;i++) {
			total += parseFloat($(elements[i]).html().trim());
		}
		$("#total_amount").html(total);
	}
	
	$('.update_qty').on("click", function(event) {
		var id = $(this).attr("id");
		product_id = id.split('-')[1];
		qty = parseInt($("#qty-"+product_id).val().trim(),10);
		$.ajax({
			type : "POST",
			url : "/cart/update",
			data : {
				"id" : parseInt(product_id,10),
				"qty" : qty
			},
			success : function(response) {
				if (response.result == "success") {
					var unit_price = parseFloat($("#unit_price-"+product_id).html().trim());
					$("#total_price-"+product_id).html(unit_price*qty);
					updateTotalAmount();
				} else {
					$("#status-"+product_id).html(response.message);
				}
			},
			error : function(data) {
				$("#status-"+product_id).html("Something went wrong");
			}
		});
	});
});
