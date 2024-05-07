$(document).ready(function() {
    $('#table_id').DataTable();
});
// 發送刪除請求
function Delete(deliveryId) {
    if (confirm('你是否要刪除這筆外送單?')) {
        console.log('Deleting delivery with ID:', deliveryId);
    } else {
        console.log('Deletion cancelled.');
    }
}
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