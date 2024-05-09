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

        // 更新页码按钮
        updatePageButtons(currentPageNumber, totalPages);

        // 加載當前頁上下兩筆資料
        loadAdjacentOrders(response.number, response.content);
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

    // 更新页码按钮
    function updatePageButtons(currentPageNumber, totalPages) {
        // 更新页码按钮的显示内容
        $('#page1 a').text(currentPageNumber > 1 ? currentPageNumber - 1 : 1);
        $('#page2 a').text(currentPageNumber);
        $('#page3 a').text(currentPageNumber < totalPages ? currentPageNumber + 1 : totalPages);

        // 根据需要添加或删除页码按钮
        if (currentPageNumber === 1) {
            $('#page1').hide();
        } else {
            $('#page1').show();
        }

        if (currentPageNumber === totalPages || totalPages === 0) {
            $('#page3').hide();
        } else {
            $('#page3').show();
        }
    }

    // 新增的页码按钮点击事件
    $('.pagination-container').on('click', '#page1, #page2, #page3', function() {
        var page = parseInt($(this).text()) - 1;
        fetchOrders(page);

        // 更新当前页码
        currentPage = page;
    });
    
    $('#goToPageBtn').click(function() {
        var pageNumber = parseInt($('#pageNumberInput').val());
        var totalPages = parseInt($('#paginationInfo').text().split('/')[1].trim());

        // 检查输入的页码是否合法
        if (pageNumber >= 1 && pageNumber <= totalPages) {
            var page = pageNumber - 1;
            fetchOrders(page);
            currentPage = page;

            // 移除所有页面项上的 active 类
            $('.pagination-container .page-item').removeClass('active');

            // 添加 active 类到指定的页面项
            $('#page' + pageNumber).addClass('active');
        } else {
            // 提示用户输入的页码无效
            alert('Invalid page number! Please enter a number between 1 and ' + totalPages);
        }
    });

    // 初始化頁面 獲得第0頁的數據
    fetchOrders(currentPage);
});
