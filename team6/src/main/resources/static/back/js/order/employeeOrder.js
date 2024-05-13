//返回主頁
function goToOrderIndex() {
	// 使用 window.location.href 将页面重定向到指定的JSP页面
	window.location.href = '/order/order.action';
}

var productPrice = 0;
$(document).ready(function() {

	$.ajax({
		url: '/order/findProduct',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			var categorySelect = $('#productCategorySelect');
			categorySelect.empty(); // 清空下拉選單
			categorySelect.append('<option value="">點擊下拉</option>');

			// 填充產品種類到下拉選單中
			$.each(response.categories, function(index, category) {
				categorySelect.append('<option value="' + category.categoryId + '">' + category.categoryName + '</option>');
			});

			// 綁定選擇事件，當選擇產品種類後加載相對應的產品
			categorySelect.change(function() {
				var selectedCategoryName = $(this).find('option:selected').text();
				productPrice = 0;

				if (selectedCategoryName === '披薩') {
					// 啟用相應的選項
					$('input[name="sauce"]').prop('disabled', false);
					$('#cheese').prop('disabled', false);
					$('#mushroom').prop('disabled', false);
				} else if (selectedCategoryName === '焗烤') {
					// 啟用相應的選項
					$('input[name="sauce"]').prop('disabled', false);
					$('#mushroom').prop('disabled', false);
				} else {
					$('input[name="sauce"]').prop('checked', false).prop('disabled', true);
					$('#cheese').prop('checked', false).prop('disabled', true);
					$('#mushroom').prop('checked', false).prop('disabled', true);
				}

				var categoryId = $(this).val();
				var products = response.product.filter(product => product.categoryId == categoryId);
				var orderProductSelect = $('#orderProductSelect');
				orderProductSelect.empty(); // 清空產品下拉選單
				orderProductSelect.append('<option value=""></option)>');
				$.each(products, function(index, product) {
					orderProductSelect.append('<option value="' + product.productId + '">' + product.productName + '</option>');
				});
				orderProductSelect.prop('disabled', false);

				$('#orderProductSelect').change(function() {
					if (response) {
						// 獲取所選產品的價格
						var selectedProductId = $(this).val();
						var selectedProduct = response.product.find(product => product.productId == selectedProductId);
						productPrice = selectedProduct.productPrice;
						console.log(productPrice);
						// 當選擇產品後，更新顯示的價格
						updateDisplayedPrice(productPrice);
					}
				});
				function updateDisplayedPrice(price) {
					// 更新顯示的價格
					$('#displayedPrice').text(price);
				}
			});
		},
		error: function(xhr, status, error) {
			console.error(error);
		}
	});
	$('input[name="sauce"]').change(function() {
		var selectedSauce = $(this).val();
		var note = selectedSauce;
		$('#noteInput').val(note);
	});

	// 當選擇加起司時觸發 change 事件
	$('#cheese').change(function() {
		if ($(this).is(":checked")) {
			$('#noteInput').val($('#noteInput').val() + ' 加起司');
			// 在此處增加 productPrice
			productPrice += 30; // 若選擇加起司，將 productPrice 加 30
			console.log('productPrice:', productPrice);
		} else {
			// 若取消勾選，將相應的價格減去
			productPrice -= 30;
			var noteValue = $('#noteInput').val();

			if (noteValue.includes('加起司')) {
				noteValue = noteValue.replace(' 加起司', '');
				$('#noteInput').val(noteValue);
			}
			console.log('productPrice:', productPrice);
		}
	});

	// 當選擇加洋菇時觸發 change 事件
	$('#mushroom').change(function() {
		if ($(this).is(":checked")) {
			$('#noteInput').val($('#noteInput').val() + ' 加洋菇');
			// 在此處增加 productPrice
			productPrice += 30; // 若選擇加洋菇，將 productPrice 加 30
			console.log('productPrice:', productPrice);
		} else {
			// 若取消勾選，將相應的價格減去
			productPrice -= 30;
			var noteValue = $('#noteInput').val();

			if (noteValue.includes('加洋菇')) {
				noteValue = noteValue.replace(' 加洋菇', '');
				$('#noteInput').val(noteValue);
			}
			console.log('productPrice:', productPrice);
		}
	});

});
function addOrder() {

	var productName = $('#orderProductSelect option:selected').text();
	var quantity = $('#quantityInput').val();
	var unitPrice = productPrice;
	var note = $('#noteInput').val();

	if (productName == '') {
		alert('請選擇產品！');
	}
	if (quantity <= 0 || quantity > 10) {
		alert('數量限 1 ~ 10 之間！');
	}

	var sauceSelected = false;
	$('input[name="sauce"]').each(function() {
		if ($(this).is(":checked")) {
			sauceSelected = true;
			return false; // 中止循環
		}
	});

	if (!$('input[name="sauce"]').prop('disabled') && !sauceSelected) {
		alert('請選擇一種醬料！');
		return; // 中止函數執行
	}

	if (productName !== '' && quantity >= 1 && quantity <= 10) {


		// 創建新的訂單明細行
		var newRow = $('<tr>');
		newRow.append('<td><input type="hidden" name="productName[]" value="' + productName + '">' + productName + '</td>');
		newRow.append('<td><input type="hidden" name="quantity[]" value="' + quantity + '">' + quantity + '</td>');
		newRow.append('<td><input type="hidden" name="unitPrice[]" value="' + unitPrice + '">' + unitPrice + '</td>');
		newRow.append('<td><input type="hidden" name="note[]" value="' + note + '">' + note + '</td>');
		newRow.append('<td><button type="button" class="btn btn-light border delete-row fw-semibold mb-0">刪除</button></td>');

		// 添加新行到表格中
		$('#orderDetailsTable').append(newRow);

		// 綁定刪除按鈕的點擊事件
		bindDeleteButton();

		// 清空div內的資料
		$('#quantityInput').val('');
		$('#noteInput').val('');
		$('input[name="sauce"]').prop('checked', false);
		$('#productCategorySelect').val('');
		$('#orderProductSelect').empty().prop('disabled', true);

		// 計算並更新總金額
		calculateTotalAmount();
	}
}

function bindDeleteButton() {
	$('.delete-row').unbind('click').click(function() {
		$(this).closest('tr').remove(); // 刪除所在行
		calculateTotalAmount(); // 重新計算總金額
	});
}


function calculateTotalAmount() {
	var totalAmount = 0;
	$('#orderDetailsTable tr').each(function() {
		var quantity = parseFloat($(this).find('input[name="quantity[]"]').val());
		var unitPrice = parseFloat($(this).find('input[name="unitPrice[]"]').val());
		totalAmount += quantity * unitPrice;
	});

	totalAmount = Math.floor(totalAmount); // 將總金額向下取整
	$('input[name="amount"]').val(totalAmount);
	console.log(totalAmount);
}

