<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户中心</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${basePath}layui/css/layui.css">
  <link rel="stylesheet" href="${basePath}fly/css/global.css">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="layui-container fly-marginTop fly-user-main">

  <jsp:include page="../common/user-nav.jsp" />
  
  
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我发的帖（<span>${totalCount}</span>）</li>
      </ul>
      <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <c:choose>
            <c:when test="${postList != null && postList.size() >0}">
              <ul class="mine-view jie-row">
                <c:forEach items="${postList}" var="post">
                  <li>
                    <a class="jie-title" href="${basePath}community/detail/${post.id}">${post.title}</a>
                    <i>${post.createTime}</i>
                    <a class="mine-edit" href="${basePath}community/toEdit/${post.id}">编辑</a>
                    <em>${post.replyCount}回复</em>
                  </li>
                </c:forEach>

              </ul>
            </c:when>
            <c:otherwise>
              <div class="fly-none">没有相关数据</div>
            </c:otherwise>
          </c:choose>

          <div style="text-align: center">
            <div id="page-view"></div>
          </div>
          <a href="" id="PageJump"></a>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script type="text/javascript">
  layui.use(['laypage','jquery'], function(){
    var laypage = layui.laypage,$ = layui.$;

    //执行一个laypage实例
    laypage.render({
      elem: 'page-view' //注意，这里的 test1 是 ID，不用加 # 号
      , count: ${totalCount} //数据总数，从服务端得到
      , curr: ${currPage}
      , limit: ${pageSize}
      , groups:3
      ,jump: function(obj, first){
        if(!first){
          $("#PageJump").attr('href','${basePath}community/user/${userCommon.role}/${userCommon.id}/home?pageIndex='+obj.curr+'&pageSize='+obj.limit)
          $("#PageJump")[0].click();
        }
      }
    });
  });
</script>
</body>
</html>