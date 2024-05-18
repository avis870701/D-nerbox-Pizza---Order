$(document).ready(function() {
	// Send AJAX request to fetch order data
	$.ajax({
		url: '/order/searchOrderByAccount', // URL to your controller method
		method: 'GET',
		dataType: 'json',
		success: function(data) {
			if (data && data.length > 0) {
				var tableBody = $('#example tbody');
				// Loop through the data and create table rows
				data.forEach(function(order) {
					var formattedOrderTime = order.orderTime.split('.')[0];
					var row = '<tr>' +
						'<td class="order-id" data-order-id="' + order.orderId + '">' + order.orderId + '</td>' +
						'<td>' + formattedOrderTime + '</td>' +
						'<td>' + '$'+order.paidAmount + '</td>' +
						'<td>' + order.payment + '</td>' +
						'<td>' + order.pickup + '</td>' +
						'<td>' + order.orderStatus + '</td>' +
						'</tr>';
					tableBody.append(row);
				});

				// Add click event for orderId cells
				$('#example').on('click', '.order-id', function() {
					var orderId = $(this).data('order-id');
					// Hide the order table and show the details table
					$('#orderTableContainer').addClass('hidden');
					$('#orderDetailsContainer').removeClass('hidden');

					// Send AJAX request to fetch order details
					$.ajax({
						url: '/order/memberSelectDetails',
						method: 'GET',
						data: { orderId: orderId },
						dataType: 'json',
						success: function(details) {
							if (details && details.length > 0) {
								var detailsBody = $('#orderDetailsTable tbody');
								detailsBody.empty(); // Clear previous details
								details.forEach(function(detail) {
									var detailRow = '<tr>' +
										'<td>' + detail.product + '</td>' +
										'<td>' + detail.quantity + '</td>' +
										'<td>' + detail.unitPrice + '</td>' +
										'</tr>';
									detailsBody.append(detailRow);
								});
							} else {
								console.log("No details found for the order.");
							}
						},
						error: function(xhr, status, error) {
							console.error("Error fetching order details: ", error);
						}
					});
				});

				// Initialize DataTable
				$('#example').DataTable();
			} else {
				console.log("No data found for the account.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching order data: ", error);
		}
	});

	// Add click event for the back button
	$('#backToOrdersBtn').on('click', function() {
		$('#orderTableContainer').removeClass('hidden');
		$('#orderDetailsContainer').addClass('hidden');
	});
});
