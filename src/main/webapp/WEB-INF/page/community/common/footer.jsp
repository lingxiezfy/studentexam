<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<div class="fly-footer">
  <p><a href="" target="">校园社区</a> 2020 &copy; <a href="" target="">学习交流中心 出品</a></p>
</div>

<script src="${basePath}layui/layui.js"></script>
<script>
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
}).use('fly');


  layui.use('util',function () {
    var util = layui.util;
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
  })
</script>