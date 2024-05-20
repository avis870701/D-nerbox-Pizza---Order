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