let wapper = document.querySelector(".wapper");
let textAll = document.querySelectorAll(".wapper .text");
let text = ["10元","20元","未中獎","飲料一瓶","40元","30元","未中獎","50元"];
for(let i = 0 ; i < textAll.length ; i++){
    textAll[i].innerHTML = text[i];
}
let isFlag = true;
let hasPlayed = false;

document.querySelector(".circle").onclick = function() {
    if (!hasPlayed) {
        if (isFlag) {
            let random = parseInt(Math.random() * 8);
            let selectedText = text[random];
            run(selectedText);
            fetchDiscountCode(selectedText);
        }
        hasPlayed = true;
    } else {
        alert("您已经抽過了,不能重複抽獎!");
    }
};

function run(text) {
    isFlag = false;
    let begin = 0;
    let timer = null;
    let basic = 1800;
    let angle = getAngleByText(text);
    timer = setInterval(function(){
        if(begin > (basic + angle)){
            isFlag = true;
            clearInterval(timer);
            alert("恭喜您抽到了 : " + text);
        }
        wapper.style.transform="rotate(" + (begin) + "deg)";
        begin += Math.ceil(basic + angle - begin) * 0.1;
    },70);
}

function getAngleByText(text) {
    switch(text) {
        case "10元":
            return 22.5;
        case "20元":
            return 66.5;
        case "未中獎":
            return 112.5;
        case "飲料一瓶":
            return 157.5;
        case "40元":
            return 338.5;
        case "30元":
            return 294.5;
        case "50元":
            return 247.5;
        default:
            return 201.5;
    }
}

function fetchDiscountCode(promotionsName) {
    $.ajax({
        url: '/getDiscountCode',
        method: 'GET',
        data: { promotionsName: promotionsName },
        success: function(response) {
            if (response) {
                alert('Your discount code is: ' + response);
            } else {
                alert('Discount code not found!');
            }
        },
        error: function() {
            alert('Error fetching discount code!');
        }
    });
}
