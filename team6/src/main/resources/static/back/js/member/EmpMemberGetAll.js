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
					+ `<th class="border-bottom-0">帳號權限</th>`
					+ `<th class="border-bottom-0">修改</th>`
					+ `<th class="border-bottom-0">刪除</th></tr></thead><tbody>`);

				$.each(response, function (i, n) {
					console.log(response);
					var tr = `<tr><td class="border-bottom-0">` + n.maid + `</td>`
						+ `<td class="border-bottom-0">` + n.mAccount + `</td>`
						+ `<td class="border-bottom-0"><a href='Member.SelectOneByID?id=` + n.maid + "'>" + n.detailBean.mName + `</a></td>`;
					if (n.detailBean.mPhoto == null) {
						tr += `<td class="border-bottom-0"><img src="/images/member/user.png" class="userphoto"></td>`;
					} else {
						tr += `<td class="border-bottom-0">` + `<img src="` + n.detailBean.mPhoto + `" class="userphoto"></td>`;
					}
					if (n.permissions == 0) {
						tr += `<td> <label> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.mAccount + `', this.value)" checked>已封鎖　　　</label>`
							+ `<label> <input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.mAccount + `', this.value)">已啟用</label></td > `;
					} else if (n.permissions == 1) {
						tr += `<td> <input type="radio" name="permissions` + i + `" value="0" onchange="change('` + n.mAccount + `', this.value)">已封鎖　　　`
							+ `<input type="radio" name="permissions` + i + `" value="1" required onchange="change('` + n.mAccount + `', this.value)" checked>已啟用</td > `;
					}
					// tr += `</form > `;
					tr += `<td class="border-bottom-0"><a href='/member/MemberGoToUpdate?account=` + n.mAccount + `'><button class="btn btn-primary" type='submit'>更新</button></a></td>`;
					tr += `<td class="border-bottom-0"><button class="btn btn-primary" type="submit" onclick="deleteAccount('` + n.mAccount + `')">刪除</button></td >`;
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
	let confirmDelete = confirm("確定要 刪除 嗎？");
	if (confirmDelete) {
		$.ajax({
			type: 'delete',
			url: '/member/Member.Delete',
			data: { "account": account },
			success: function () {
				alert("已刪除!");
			},
			error: function () {
				alert("已取消刪除!"); window.location.href = "/member/MemberGetAll/1";
			}
		});
	}
}

function change(account, permissions) {
	$.ajax({
		type: 'put',
		url: '/Member.UpdatePermissions',
		data: {
			"account": account,
			"permissions": permissions
		},
		success: function () {
			alert("已更改權限成功!")
			window.location.href = "/Member.SelectAll";
		}

	});
}