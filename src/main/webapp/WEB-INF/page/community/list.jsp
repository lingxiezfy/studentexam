<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>校园社区</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${basePath}layui/css/layui.css">
  <link rel="stylesheet" href="${basePath}fly/css/global.css">
</head>
<body>

<jsp:include page="./common/header.jsp" />

<jsp:include page="./common/column.jsp"/>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8">
      <div class="fly-panel" style="margin-bottom: 0;">

        <jsp:include page="./common/filter.jsp"/>

        <c:choose>
          <c:when test="${postList != null && postList.size() > 0}">
            <ul class="fly-list">
              <c:forEach items="${postList}" var="post">
                <li>
                  <a href="${basePath}community/user/${post.userRole}/${post.userId}/index" class="fly-avatar">
                    <img src="${basePath}fly/images/avatar/default.png" alt="${post.userName}">
                  </a>
                  <h2>
                    <a class="layui-badge">${post.topicName}</a>
                    <a href="${basePath}community/detail/${post.id}">${post.title}</a>
                  </h2>
                  <div class="fly-list-info">
                    <a href="${basePath}community/user/${post.userRole}/${post.userId}/index" link>
                      <cite>${post.userName}</cite>
                    </a>
                    <span>${post.createTime}</span>
                    <span class="fly-list-nums"><i class="iconfont icon-pinglun1" title="回复"></i> ${post.replyCount} </span>
                  </div>
                  <div class="fly-list-badge">
                    <c:if test="${post.topFlag == 1}">
                      <span class="layui-badge layui-bg-black">置顶</span>
                    </c:if>
                    <c:if test="${post.excellentFlag == 1}">
                      <span class="layui-badge layui-bg-red">精帖</span>
                    </c:if>
                  </div>
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
    <div class="layui-col-md4">
      <dl class="fly-panel fly-list-one">
        <dt class="fly-panel-title">本周热议</dt>
        <c:choose>
          <c:when test="${hotList != null && hotList.size() > 0}">
            <c:forEach items="${hotList}" var="post">
              <dd>
                <a href="${basePath}community/detail/${post.id}">${post.title}</a>
                <span><i class="iconfont icon-pinglun1"></i> ${post.replyCount}</span>
              </dd>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="fly-none">没有相关数据</div>
          </c:otherwise>
        </c:choose>

      </dl>
    </div>
  </div>
</div>

<jsp:include page="./common/footer.jsp"/>

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
              $("#PageJump").attr('href','${basePath}community/list?pageIndex='+obj.curr+'&pageSize='+obj.limit+'&topic=${topic}&excellent=${excellent}&orderBy=${orderBy}')
              $("#PageJump")[0].click();
          }
        }
    });
  });

</script>
</body>
</html>