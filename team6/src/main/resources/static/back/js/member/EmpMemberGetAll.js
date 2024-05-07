var indexPage = 1;
$(function () {
    loadPage(indexPage);
});
function loadPage(indexPage) {
    $.ajax({
        type: 'get',
        url: '/member/MemberGetAll/' + indexPage,
        contentType: 'application/json',
        success: function (response) {
            $('#showmember').empty("");
            if (response == null) {
                $('table').prepend('<tr><td>no result</td></tr>');
            } else {
                var table = $('#showmember');
                table.append(`<thead class="text-dark fs-4"><tr>`
                    + `<th class="border-bottom-0">會員ID</th>`
                    + `<th class="border-bottom-0">會員帳號</th>`
                    + `<th class="border-bottom-0">會員名稱</th>`
                    + `<th class="border-bottom-0">會員頭貼</th>`
                    + `<th class="border-bottom-0">註冊日期</th>`
                    + `<th class="border-bottom-0">修改</th>`
                    + `<th class="border-bottom-0">刪除</th></tr></thead><tbody>`);

                $.each(response, function (i, n) {
                    console.log(response);
                    var tr = `<tr><td class="border-bottom-0">` + n.maid
                        + `</td><td class="border-bottom-0">` + n.mAccount + `</td><td class="border-bottom-0"><a href='Member.SelectOneByID?id=` + n.maid + "'>" + n.detailBean.mName + `</a></td><td class="border-bottom-0">` + `<img src="` + n.detailBean.mPhoto + `" class="userphoto">` + `</td><td class="border-bottom-0">` + n.detailBean.registrationDate + "</td>";
                    if (n.permissions == 0) {
                        tr += `< td class="border-bottom-0"> <label> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.account + `', this.value)" checked>已封鎖</label>`
                            + `< label > <input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.account + `', this.value)">已啟用</label></td > `;
                    } else if (n.permissions == 1) {
                        tr += `< td class="border-bottom-0"> <label> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.account + `', this.value)">已封鎖</label>`
                            + `< label > <input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.account + `', this.value)" checked>已啟用</label></td > `;
                    }
                    // tr += `</form > `;
                    tr += `<td class="border-bottom-0"><a href='MemberGoToUpdate?account=` + n.account + `'><button class="btn btn-primary" type='submit'>更新</button></a></td>`;
                    tr += `<td class="border-bottom-0"><button class="btn btn-primary" type="submit" onclick="deleteAccount('` + n.account + `')">刪除</button></td >`;
                    tr += "</tr>";
                    table.append(tr);
                })
                table.append("</tbody>");
            }
        }
    });
}

function page(page) {
    indexPage = page;
    loadPage(indexPage);
}

function deleteAccount(account) {
    $.ajax({
        type: 'delete',
        url: '/Member.Delete',
        data: { "account": account },
        success: function () {
            window.location.href = "/Member.SelectAll";
        }
    });
}