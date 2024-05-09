$(document).ready(function() {
    $('#table_id').DataTable();
});
// 發送刪除請求
function Delete(deliveryId) {
    if (confirm("確定要刪除這筆訂單嗎？")) {
        $.ajax({
            type: 'DELETE',
            url: '/delivery/delete/' + deliveryId,
            success: function(result) {
                console.log('刪除成功:', result);
                // 找到对应的表格行并隐藏
                $('#table_id').find('tr').each(function() {
                    if ($(this).find('#did').text() === deliveryId.toString()) {
                        $(this).hide(); 
                        return false; 
                    }
                });
                         // window.location.href = '/delivery/home';
            },
            error: function(xhr, status, error) {
                console.error('刪除失敗:', error);
                alert('刪除訂單失敗，請稍後再試。');
            }
        });
    }
}
//新增外送單
//新增訂單
function addDelivery() {
// 獲取表單中的資料
let cname = document.getElementById('cname').value;
let phone = document.getElementById('phone').value;
let product = document.getElementById('product').value;
let num = document.getElementById('num').value;

// 構建要發送的資料物件
let Data = {
    cname: cname,
    phone: phone,
    product: product,
    num: num,
};

// 發送新增請求
$.ajax({
    type: 'POST',
    url: '/delivery/insert', 
    contentType: 'application/json',
    data: JSON.stringify(Data),
    success: function(response) {
        console.log('新增成功:', response);
    },
    error: function(xhr, status, error) {
        console.error('新增失敗:', error);
    }
});
}