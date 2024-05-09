// 發送刪除請求
    function Delete(deliveryId) {
        if (confirm("確定要刪除這筆訂單嗎？")) {
        $.ajax({
            type: 'DELETE',
            url: '/delivery/delete/' + deliveryId,
            success: function(result) {
                alert('刪除成功');
                window.location.href = '/delivery/home';
                // 找到对应的表格行并隐藏
                // $('#table_id').find('tr').each(function() {
                //     if ($(this).find('#did').text() === deliveryId.toString()) {
                //         $(this).hide(); 
                //         return false; 
                //     }
                // });
            },
            error: function(xhr, status, error) {
                console.error('刪除失敗:', error);
                alert('刪除訂單失敗，請稍後再試。');
            }
        });
    }
    }
    //發送新增請求
    function addDelivery() {
        let orderid = $('#orderid').val();
        let date = $('#date').val();
        let address= $('#address').val();

        let Data = {
                orderid: orderid,
                date: date,
                address: address
            };  

   $.ajax({
        type: 'POST',
        url: '/delivery/insert', 
        contentType: 'application/json',
        data: JSON.stringify(Data),
        success: function(response) {
            console.log('新增成功:', response);
            window.location.href = "/delivery/home";
        },
        error: function(xhr, status, error) {
            console.error('新增失敗:', error);
        }
    });
    }
    //發送更新請求
    function update() {
        // 獲取表單中的資料
        let id = $('#id').val();
        let orderid = $('#orderid').val();
        let date = $('#date').val();
        let address= $('#address').val();
        let status = $('#status').val();

        // 建成json
        let Data = {
            id : id,
            orderid: orderid,
            date: date,
            address: address,
            status: status
        };
        // console.log(Data);
    
        $.ajax({
            type: 'PUT',
            url: '/delivery/upd', 
            contentType: 'application/json',
            data: JSON.stringify(Data),
            success: function(response) {
                alert('更新成功');
                window.location.href = "/delivery/home";
            },
            error: function(xhr, status, error) {
                console.error('更新失敗:', error);
            }
        });
    }


