$(function () {
    ul(`${emp.empPermissions}`, `${emp.detailBean.deptBean.deptno}`);
});
function ul(empPermissions, deptno) {
    let ul = $('#sidebarnav');
    let li = `  <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">後台功能列表</span>
            </li>`;
    if (empPermissions == 1 || empPermissions == 2) {
        li += ` <li class="sidebar-item">
          <a class="sidebar-link" href="" aria-expanded="false" onclick="empChangeHref()" id="Member">
            <span>
              <i class="ti ti-user-plus"></i>
            </span>
            <span class="hide-menu">會員管理功能</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="" aria-expanded="false" id="product">
            <span>
              <i class="ti ti-article"></i>
            </span>
            <span class="hide-menu">產品管理功能</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="#" aria-expanded="false" id="order">
            <span>
              <i class="ti ti-alert-circle"></i>
            </span>
            <span class="hide-menu">訂單管理功能</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="./ui-card.html" aria-expanded="false" id="reservation">
            <span>
              <i class="ti ti-cards"></i>
            </span>
            <span class="hide-menu">訂位管理功能</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="./ui-forms.html" aria-expanded="false" id="delivery">
            <span>
              <i class="ti ti-file-description"></i>
            </span>
            <span class="hide-menu">外送管理功能</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link" href="./ui-typography.html" aria-expanded="false" id="promotions">
            <span>
              <i class="ti ti-typography"></i>
            </span>
            <span class="hide-menu">活動管理功能</span>
          </a>
        </li>`;
        ul.append(li);
        $('#Member').attr('href', 'Member.SelectAll/1');
        $('#product').attr('href', 'Member');
        $('#order').attr('href', 'Member');
        $('#reservation').attr('href', 'Member');
        $('#delivery').attr('href', 'Member');
        $('#promotions').attr('href', 'Member');
    } if (empPermissions == 3) {
        switch (deptno) {
            case '601': {
                li += `<li class="sidebar-item">
              <a class="sidebar-link" href="" aria-expanded="false" onclick="empChangeHref()" id="Member">
                <span>
                  <i class="ti ti-user-plus"></i>
                </span>
                <span class="hide-menu">會員管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#Member').attr('href', 'Member.SelectAllByNotHidden/1');
                break;
            }
            case '602': {
                li += ` <li class="sidebar-item">
              <a class="sidebar-link" href="" aria-expanded="false" id="product">
                <span>
                  <i class="ti ti-article"></i>
                </span>
                <span class="hide-menu">產品管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#product').attr('href', 'Member');
                break;
            }
            case '603': {
                li += `<li class="sidebar-item">
              <a class="sidebar-link" href="#" aria-expanded="false" id="order">
                <span>
                  <i class="ti ti-alert-circle"></i>
                </span>
                <span class="hide-menu">訂單管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#order').attr('href', 'Member');
                break;
            }
            case '604': {
                li += `<li class="sidebar-item">
              <a class="sidebar-link" href="./ui-typography.html" aria-expanded="false" id="promotions">
                <span>
                  <i class="ti ti-typography"></i>
                </span>
                <span class="hide-menu">活動管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#promotions').attr('href', 'Member');
                break;
            }
            case '605': {
                li += `<li class="sidebar-item">
              <a class="sidebar-link" href="./ui-card.html" aria-expanded="false" id="reservation">
                <span>
                  <i class="ti ti-cards"></i>
                </span>
                <span class="hide-menu">訂位管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#reservation').attr('href', 'Member');
                break;
            }
            case '606': {
                li += ` <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-forms.html" aria-expanded="false" id="delivery">
                <span>
                  <i class="ti ti-file-description"></i>
                </span>
                <span class="hide-menu">外送管理功能</span>
              </a>
            </li>`;
                ul.append(li);
                $('#delivery').attr('href', 'Member');
                break;
            }
        }
    }
};


function empChangeHref() {
    if (`${emp.empPermissions}` == 1 || `${emp.empPermissions}` == 2) {
        // alert('1' + `${emp.detailBean.deptBean.deptname}` + `${emp.detailBean.deptno}` + `${emp.detailBean.deptBean.deptno}`);
        $('#Member').attr('href', 'Member.SelectAll/1');
        $('#product').attr('href', 'Member');
        $('#order').attr('href', 'Member');
        $('#reservation').attr('href', 'Member');
        $('#delivery').attr('href', 'Member');
        $('#promotions').attr('href', 'Member');
    }
    if (`${emp.empPermissions}` == 3) {
        // $('#Member').attr('href', 'Member.SelectAllByNotHidden/1');
        let deptno = `${emp.detailBean.deptBean.deptno}`;
        switch (deptno) {
            case '601': { $('#Member').attr('href', 'Member.SelectAllByNotHidden/1'); }
            case '602': { $('#product').attr('href', 'Member'); }
            case '603': { $('#order').attr('href', 'Member'); }
            case '604': { $('#promotions').attr('href', 'Member'); }
            case '605': { $('#reservation').attr('href', 'Member'); }
            case '606': { $('#delivery').attr('href', 'Member'); }
        }
        // alert('3' + `${emp.detailBean.deptBean.deptname}` + `${emp.detailBean.deptno}` + `${emp.detailBean.deptBean.deptno}`);

    }
}