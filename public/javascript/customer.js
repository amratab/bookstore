$(function () {
	$("#signupForm")[0].reset();
	$("#signinForm")[0].reset();
	$("#signupForm").on("submit", function(event) {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : '/signup',
			data: $(this).serialize(),
			success : function(response) {
				if (response.result == "success") {
					$("#signupModal").modal('hide');
					$("#signupForm")[0].reset();
					alert("User created successfully! Please sign in to continue.");
				} else {
					$("#statusSpan").html(response.message);
				}
			},
			error : function(data) {
				$("#statusSpan").html("Something went wrong");
			}
		});
	});
	
	$("#signinForm").on("submit", function(event) {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : '/signin',
			data: $(this).serialize(),
			success : function(response) {
				if (response.result == "success") {
					$("#signinForm")[0].reset();
					$("#signinModal").modal('hide');
					window.location = "/";
				} else {
					$("#status2Span").html(response.message);
				}
			},
			error : function(data) {
				$("#status2Span").html("Something went wrong");
			}
		});
	});
	
	$("#signoutBtn").on("click", function(event) {
		event.preventDefault();
		$.ajax({
			type : "POST",
			url : '/logout',
			success : function(response) {
					window.location = "/";
			}
		});
	}); 
});
