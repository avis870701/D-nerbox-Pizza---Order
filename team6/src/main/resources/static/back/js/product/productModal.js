// modal
$('#productModal').on('show.bs.modal', function (event) {
    // 預設值,等於一鍵輸入
    $('#createproductName').val('測測');
    $('#createproductDesc').val('測測測測');
    $('#modal-productImg_url').val('');
    $('#createproductPrice').val('100');
    $('#createproductQuantity').val('10');
});