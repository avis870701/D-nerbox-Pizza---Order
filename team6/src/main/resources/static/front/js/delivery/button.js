// 按下外送按钮顯示/隱藏定位按钮和地址输入框
// 用于跟踪外送部分是否可见
let deliveryVisible = false; 
$('#delivery').click(function() {
    if (!deliveryVisible) {
        $('#catch').show();
        $('#catchbar').show();
        $('#enter').show();
        $('#submit').show();
        $('#deliveryaddress').show();
        deliveryVisible = true;
    } else {
        $('#catch').hide();
        $('#catchbar').hide();
        $('#enter').hide();
        $('#submit').hide();
        $('#deliveryaddress').hide();
        deliveryVisible = false;
    }
});

// 按下景點外送按钮顯示/隱藏
let Attractions = false;

$('#Attractions').click(function(){
    if (!deliveryVisible) {
        $('#point').show();
        $('#Attraction1').show();
        $('#Attraction2').show();
    deliveryVisible = true;
    } else {
        $('#point').hide();
        $('#Attraction1').hide();
        $('#Attraction2').hide();
    deliveryVisible = false;
    }
});

$('#submit').click(function () {
    let catchval = $('#catchbar').val()
    let date = $('#date').val()

    const matchesPattern = checkAddressFormat(catchval);

    let data = {
        address: catchval,
        date: date
    }
    if (catchval.length > 6) {
        if (matchesPattern) {
            $.ajax({
                type: 'POST',
                url: '/save',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    location.href = '/order/deliveryOrder';   
                },
            })
        } else {
            alert('請输入桃園市中壢區及路名。');
        }
    } else {        
        alert('输入字串長度太少。');
    }
});



// 使用正则表达式的 test() 方法检查输入字符串是否符合模式
function checkAddressFormat(inputString) {
const pattern = /桃園市|中壢區/;
return pattern.test(inputString);
}



$('#Attraction2').click(function () {
let Attraction1 = $('#Attraction1').val();
let date = $('#date').val()
console.log(Attraction1);
console.log(date);
let data = {
    address: Attraction1,
    date: date
}
$.ajax({
    type: 'POST',
    url: '/save',
    contentType: 'application/json',
    data: JSON.stringify(data),
    success: function (result) {
        // alert('。');
        window.location.href = '/order/deliveryOrder';
    },
})
})