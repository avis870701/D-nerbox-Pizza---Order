var indexPage = 1;
$(function() {

	showByName('none');
	loadHiddenPage(indexPage);

	$('#select').on('input', function() {
		var keyword = $(this).val().trim().toLowerCase();

		if (keyword === "") {
			loadHiddenPage(indexPage);
			showAll('block');
			showByName('none');

		} else {
			loadByNamePage(keyword);
			showAll('none');
			showByName('block');

		}
	});
});
function showByName(type) {
	var table = document.getElementById('showmemberByName');
	var tablePage = document.getElementById('showpageByName');
	if (type === 'none') {
		console.log('no');
		table.style.display = 'none';
		tablePage.style.display = 'none';
	} else {
		console.log('show');
		table.style.display = null;
		tablePage.style.display = null;
	}
}

function showAll(type) {
	var table = document.getElementById('showmember');
	var tablePage = document.getElementById('showpage');
	if (type === 'none') {
		console.log('all no');
		table.style.display = 'none';
		tablePage.style.display = 'none';
	} else {
		console.log('all show');
		table.style.display = null;
		tablePage.style.display = null;

	}
}


function loadHiddenPage(indexPage) {
	$.ajax({
		type: 'get',
		url: '/emp/MemberGetAllByNotHidden/' + indexPage,
		contentType: 'application/json',
		success: function(response) {
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

				$.each(response, function(i, n) {
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
					tr += `<td class="border-bottom-0"><a href='/emp/MemberGoToUpdate?account=` + n.mAccount + `'><button class="btn btn-primary" type='submit'>更新</button></a></td>`;
					tr += `<td class="border-bottom-0"><button class="btn btn-primary" type="submit" onclick="deleteAccount('` + n.mAccount + `')">刪除</button></td >`;
					tr += "</tr>";
					table.append(tr);
				})
				table.append("</tbody>");
			}
		}
	});
}

function loadByNamePage(name) {
	$.ajax({
		type: 'get',
		url: '/emp/Member.SelectByNameAndNotHidden',
		data: {
			mName: name
		},
		contentType: 'application/json',
		success: function(response) {
			var table = $('#showmemberByName');
			var tablePage = $('#showpageByName');
			table.empty("");
			tablePage.empty("");
			if (response == null) {
				table.prepend('<tr><td class="border-bottom-0">no result</td></tr>');
				tablePage.prepend('<tr><td class="border-bottom-0"></td></tr>');
			} else {
				let size = response.length;
				table.append(`<thead class="text-dark fs-4"><tr>`
					+ `<th class="border-bottom-0">會員ID</th>`
					+ `<th class="border-bottom-0">會員帳號</th>`
					+ `<th class="border-bottom-0">會員名稱</th>`
					+ `<th class="border-bottom-0">會員頭貼</th>`
					+ `<th class="border-bottom-0">帳號權限</th>`
					+ `<th class="border-bottom-0">修改</th>`
					+ `<th class="border-bottom-0">刪除</th></tr></thead><tbody>`);
					
				tablePage.append(`<tr><td class="border-bottom-0">總共有 ` + size + ` 筆資料</td></tr>`)

				$.each(response, function(i, n) {
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
					tr += `<td class="border-bottom-0"><a href='/emp/MemberGoToUpdate?account=` + n.mAccount + `'><button class="btn btn-primary" type='submit'>更新</button></a></td>`;
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
	loadHiddenPage(indexPage);
}

function deleteAccount(account) {
	let confirmDelete = confirm("確定要 刪除 嗎？");
	if (confirmDelete) {
		$.ajax({
			type: 'delete',
			url: '/emp/Member.Delete',
			data: { "account": account },
			success: function() {
				alert("已刪除!");
				window.location.href = "/emp/Member.SelectAllByNotHidden/1"
			},
			error: function() {
				alert("已取消刪除!");

			}
		});
	}
}

function change(account, permissions) {
	$.ajax({
		type: 'PUT',
		url: '/emp/Member.UpdatePermissions',
		data: {
			"account": account,
			"permissions": permissions,
			"empPermissions": 1
		},
		success: function() {
			alert("已更改權限成功!")
			//window.location.href = "/emp/Member.SelectAllByNotHidden/1";
		}

	});
}