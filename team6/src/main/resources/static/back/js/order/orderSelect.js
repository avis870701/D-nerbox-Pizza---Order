$(document).ready(function() {
    var pageSize = 10; // 顯示的筆數
    var currentPage = 0; // 目前頁碼

    // 发送 AJAX 请求
    function fetchOrders(page) {
        $.ajax({
            url: 'orderSelectAll', 
            type: 'GET', 
            dataType: 'json', 
            data: { page: page, size: pageSize }, // 分頁參數
            success: function(response) { // 請求成功時執行的function
                // 清空表格内容
                $('#orderTableBody').empty();
                // 遍歷返回的數據並將每一行添加到表格中
                $.each(response.content, function(index, order) {
                    var row = '<tr>' +
                        '<td>' + order.orderId + '</td>' +
                        '<td>' + order.account + '</td>' +
                        '<td>' + order.oriAmount + '</td>' +
                        '<td>' + order.discount + '</td>' +
                        '<td>' + order.discountPrice + '</td>' +
                        '<td>' + order.paidAmount + '</td>' +
                        '<td>' + order.payment + '</td>' +
                        '<td>' + order.pickup + '</td>' +
                        '<td>' + order.orderStatus + '</td>' +
                        '<td>' + order.cancelNote + '</td>' +
                        '</tr>';
                    $('#orderTableBody').append(row);
                });

                // 更新分頁狀態
                updatePagination(response);
            },
            error: function(xhr, status, error) { // 请求失敗時執行的function
                console.error(error); 
            }
        });
    }

    // 更新分頁狀態和顯示信息
    function updatePagination(response) {
        var totalPages = response.totalPages;
        var totalElements = response.totalElements;
        var currentPageNumber = response.number + 1;

        // 更新分頁信息顯示
        $('#paginationInfo').text('Total Records: ' + totalElements + ', Page: ' + currentPageNumber + ' / ' + totalPages);

        // 更新分頁按鈕狀態
        if (response.first) {
            $('#firstPage, #prevPage').addClass('disabled');
        } else {
            $('#firstPage, #prevPage').removeClass('disabled');
        }
        if (response.last) {
            $('#lastPage, #nextPage').addClass('disabled');
        } else {
            $('#lastPage, #nextPage').removeClass('disabled');
        }
    }

    // 上一頁按鈕點擊事件
    $('#prevPage').click(function() {
        if (!$(this).hasClass('disabled')) {
            currentPage--;
            fetchOrders(currentPage);
        }
    });

    // 下一頁按鈕點擊事件
    $('#nextPage').click(function() {
        if (!$(this).hasClass('disabled')) {
            currentPage++;
            fetchOrders(currentPage);
        }
    });

    // 第一頁按鈕點擊事件
    $('#firstPage').click(function() {
        if (!$(this).hasClass('disabled')) {
            currentPage = 0;
            fetchOrders(currentPage);
        }
    });

    // 最后一頁按鈕點擊事件
    $('#lastPage').click(function() {
        if (!$(this).hasClass('disabled')) {
            var totalPages = parseInt($('#paginationInfo').text().split('/')[1].trim());
            currentPage = totalPages - 1;
            fetchOrders(currentPage);
        }
    });

    // 初始化頁面 獲得第一頁的數據
    fetchOrders(currentPage);
});
