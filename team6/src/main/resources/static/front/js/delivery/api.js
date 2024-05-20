 //是否開啟定位
 function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else {
        alert("抱歉，您的浏览器不支持地理位置功能。");
    }
}   
function showPosition(position) {
const latitude = position.coords.latitude;
const longitude = position.coords.longitude;


// 使用 Google Maps Geocoding API 获取地理位置信息
const apiKey = 'AIzaSyDHPHQzwPNwxLBTrnrDlrXIa_0Qh9bPqQU';
const apiEndpoint = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${apiKey}`;

fetch(apiEndpoint)
    .then(response => response.json())
    .then(data => {
        if (data.results && data.results.length > 0) {
            const addressComponents = data.results[0].address_components;
            // let addressDetails = '';
            let addressDetails = '';
            //印出取得json字串
            console.log(addressComponents);
            // addressDetails = (addressComponents[5].long_name + addressComponents[4].long_name + addressComponents[3].long_name + addressComponents[2].long_name+addressComponents[1].long_name + addressComponents[0].long_name);
           
            addressDetails = (addressComponents[2].long_name+addressComponents[1].long_name + addressComponents[0].long_name);
           
            // 找到要放置输入字段的元素
            const catchInput = document.getElementById("catchbar");    
            // 将地址信息设置为输入字段的值
            if (catchInput) {
                catchInput.value = addressDetails;
            } else {
                console.log("找不到外送信息输入字段。");
            }
        } else {
            console.log("未找到有效的地理位置信息。");
        }
    })
    .catch(error => {
        console.log("获取地理位置信息失败：" + error);
    });
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            alert("用户拒绝了获取地理位置的请求。");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("位置信息不可用。");
            break;
        case error.TIMEOUT:
            alert("获取位置信息超时。");
            break;
        case error.UNKNOWN_ERROR:
            alert("发生了未知错误。");
            break;
        }
    }