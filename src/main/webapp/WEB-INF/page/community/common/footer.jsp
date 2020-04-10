<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<div class="fly-footer">
  <p><a href="" target="">校园社区</a> 2020 &copy; <a href="" target="">学习交流中心 出品</a></p>
</div>
<script type="text/javascript" src="${basePath }js/mySocket.js"></script>
<script src="${basePath}layui/layui.js"></script>
<script>
    <c:forEach items="${groupList}" var="group">
    registerToServer(${group.groupId},${userCommon.role},${userCommon.id});
    </c:forEach>

  layui.cache.page = 'user';
  layui.cache.user = {
    username: '游客'
    ,uid: -1
    ,avatar: '${basePath}fly/images/avatar/00.jpg'
    ,experience: 83
    ,sex: '男'
  };
  layui.config({
    base: '${basePath}fly/mods/'  //这里实际使用时，建议改成绝对路径
  }).extend({
    fly: 'index'
  }).use(['fly','face'],function () {
    var $ = layui.$
            ,fly = layui.fly;
    $('.detail-body').each(function () {
      $(this).html(fly.content(this.innerHTML))
    });
  });


  layui.use(['layer', 'util','layim','jquery'],function () {
    var util = layui.util, layer = layui.layer;
    //固定Bar
    util.fixbar({
      bar1: '&#xe642;'
      , bgcolor: '#009688'
      , click: function (type) {
        if (type === 'bar1') {
          // layer.msg('打开 index.js，开启发表新帖的路径');
          location.href = '${basePath}community/toAdd';
        }
      }
    });

    var layim = layui.layim,$ = layui.$;
    //基础配置
    layim.config({
      right:'70px',
      isfriend:false,
      min:true,
      title:"${userCommon.name}",
      init: {
        mine:{
          username: "${userCommon.name}" //我的昵称
          ,id: "${userCommon.role}_${userCommon.id}" //我的ID
          ,status: "online" //在线状态 online：在线、hide：隐身
          ,avatar: "${basePath }fly/images/avatar/default.png" //我的头像
          ,sign: '<c:if test="${userCommon.role == 1}">学生</c:if><c:if test="${userCommon.role == 2}">教师</c:if><c:if test="${userCommon.role == 3}">管理员</c:if>'
        },
        group: [
            <c:forEach items="${groupList}" var="group">
            {
                groupname: "${group.groupName}" //群组名
                ,id: "${group.groupId}" //群组ID
                ,avatar: "${basePath }fly/images/avatar/0.jpg" //群组头像
            },
            </c:forEach>
        ]
      } //获取主面板列表信息，下文会做进一步介绍

      //扩展工具栏，下文会做进一步介绍（如果无需扩展，剔除该项即可）
      ,tool: [{
        alias: 'code' //工具别名
        ,title: '代码' //工具名称
        ,icon: '&#xe64e;' //工具图标，参考图标文档
      }]
    });
    layim.on('tool(code)', function(insert, send, obj){ //事件中的tool为固定字符，而code则为过滤器，对应的是工具别名（alias）
      layer.prompt({
        title: '插入代码'
        ,formType: 2
        ,shade: 0
      }, function(text, index){
        layer.close(index);
        insert('[pre class=layui-code]' + text + '[/pre]'); //将内容插入到编辑器，主要由insert完成
        //send(); //自动发送
      });
    });
    layim.on('sendMessage', function(res) {
      var mine = res.mine; //包含我发送的消息及我的信息
      var to = res.to; //对方的信息
      if(to.type === 'group'){
        sendGroupMessage(to.id,mine.content)
      }
      //私聊
      if(to.type === 'friend'){
          var ids = to.id.split('_');
        sendMessage(ids[0],ids[1],mine.content)
      }
    });
    $('.fly-imActive').on('click',function (a) {
      var target = a.target.dataset;
      if(target.role === '${userCommon.role}' && target.id === '${userCommon.id}'){
        layer.msg('不必自言自语！', {shift: 6});
        return;
      }else {
        //私聊
        layim.chat({
          name: target.name //名称
          ,type: 'friend' //聊天类型
          ,avatar: '${basePath }fly/images/avatar/default.png' //头像
          ,id: target.role+'_'+target.id //好友id
        })
      }
    });
  });

  // 处理一条解析后的消息
  function addOneMessage(message){
    if(message.messageType === "GroupMessage"){
      if(message.author.role === ${userCommon.role} && message.author.id === ${userCommon.id}){
        return;
      }
      layui.layim.getMessage({
        username: message.author.name //消息来源用户名
        ,avatar: "${basePath }fly/images/avatar/default.png" //消息来源用户头像
        ,id: message.messageId //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
        ,type: "group" //聊天窗口来源类型，从发送消息传递的to里面获取
        ,content: message.content //消息内容
        ,cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
        ,mine: false //是否我发送的消息，如果为true，则会显示在右方
        ,fromid: message.author.role+"_"+message.author.id //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
        ,timestamp: message.sendMills //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
      });
    }else if(message.messageType === "PrivateMessage"){
        //私聊消息
        layui.layim.getMessage({
            username: message.author.name //消息来源用户名
            ,avatar: "${basePath }fly/images/avatar/default.png" //消息来源用户头像
            ,id: message.author.role+"_"+message.author.id //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
            ,type: "friend" //聊天窗口来源类型，从发送消息传递的to里面获取
            ,content: message.content //消息内容
            ,cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）
            ,mine: false //是否我发送的消息，如果为true，则会显示在右方
            ,fromid: message.author.role+"_"+message.author.id //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
            ,timestamp: message.sendMills //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000
        });
    } else if(message.messageType === "SystemMessage"){
        layui.layim.getMessage({
            system: true //系统消息
            ,id: message.messageId || (message.author.role+"_"+message.author.id) //聊天窗口ID,这里为了方便，沿用了author，实际上是需要发送的对象
            ,type: (message.messageId === 0 || message.messageId === '0')?"friend":"group" //聊天窗口类型
            ,content: message.content
        });
    }else {
      console.log("未解析消息！")
    }
  }
</script>