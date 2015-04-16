$(function() {
	$("#newProductForm").on("submit", function() {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : $(this).attr('action'),
			data: $(this).serialize(),
			success : function(response) {
				if (response.result == "success") {
					window.location = '/';
					alert("Product created successfully!");
				} else {
					$("#prodStatus").html(response.message);
				}
			},
			error : function(data) {
				$("#prodStatus").html("Something went wrong");
			}
		});
	});
	
	$("#editProductForm").on("submit", function() {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : $(this).attr('action'),
			data: $(this).serialize(),
			success : function(response) {
				if (response.result == "success") {
					window.location = '/';
					alert("Product saved successfully!");
				} else {
					$("#prodStatus").html(response.message);
				}
			},
			error : function(data) {
				$("#prodStatus").html("Something went wrong");
			}
		});
	});
	
	
});
