var socketServerUrl = "ws://localhost:8080/ws/server";

var socket;
if (typeof (WebSocket) == "undefined") {
    console.log("遗憾：您的浏览器不支持WebSocket");
} else {
    console.log("恭喜：您的浏览器支持WebSocket");

    //实现化WebSocket对象
    //指定要连接的服务器地址与端口建立连接
    //注意ws、wss使用不同的端口。我使用自签名的证书测试，
    //无法使用wss，浏览器打开WebSocket时报错
    //ws对应http、wss对应https。
    socket = new WebSocket(socketServerUrl);
    //连接打开事件
    socket.onopen = function() {
        console.log("Socket 已打开");
    };
    //收到消息事件
    socket.onmessage = function(msg) {
        console.log("收到消息：%s", msg.data);
        var json = JSON.parse(msg.data);
        if(json){
            addOneMessage(json);
        }else {
            console.log("消息格式有误,未解析:%s", msg.data);
        }
    };
    //连接关闭事件
    socket.onclose = function() {
        console.log("Socket已关闭");
    };
    //发生了错误事件
    socket.onerror = function() {
        console.log("Socket发生了错误");
    };

    //窗口关闭时，关闭连接
    window.unload=function() {
        socket.close();
    };
}

// 向服务器注册身份
function registerToServer(groupId,role,userId) {
    sendToServer('group;'+groupId+';in;'+role+';'+userId);
}

// 向服务器发送群消息
function sendGroupMessage(groupId,content) {
    sendToServer('group;'+groupId+';msg; ;'+content);
}

// 向服务器发送私聊消息
function sendMessage(role,id,content) {
    sendToServer('friend;'+role+';'+id+'; ;'+content);
}

// 向服务器发送群发消息
function sendToServer(message) {
    if(message){
        if(socket.readyState === 1){
            socket.send(message);
        }else {
            console.log("消息发送失败，延迟发送");
            setTimeout(function () {
                sendToServer(message)
            },2000)
        }
    }else {
        console.log("消息发送失败:"+message);
    }
}


