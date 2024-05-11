
		//update details ajax
		
		
		//update note
		$(document).on('click', '.updateNote-btn', function() {
    var detailsId = $(this).prev('.details-id-input').val();
    console.log('detailsId:', detailsId);

    // 弹出 prompt
    var userInput = prompt("請輸入取消原因：");

    // 如果用户点击了确定并且输入了值
    if (userInput !== null && userInput.trim() !== '') {
        // 发送 AJAX 请求到 Controller
        $.ajax({
            url: '/order/updateNote', // 根据你的实际路径修改 URL
            type: 'PUT', // 根据你的 Controller 配置
            data: {
                detailsId: detailsId, // 将 detailsId 作为数据发送
                note: userInput // 将用户输入的值作为数据发送
            },
            success: function(response) {
                // 请求成功后执行的操作
                loadOrderDetails(orderId);
                console.log("update note Sucessfully!");
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    } else {
        console.log("取消操作");
    }
});

//可以update 但是updatenote完畫面部會刷新
//updatenote還要做一個 點擊文字可以編輯的功能

