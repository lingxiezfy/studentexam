<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>用户主页</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${basePath}layui/css/layui.css">
  <link rel="stylesheet" href="${basePath}fly/css/global.css">
</head>
<body style="margin-top: 65px;">

<jsp:include page="../common/header.jsp" />

<div class="fly-home fly-panel">
  <img src="${basePath}fly/images/avatar/default.png" alt="${user.name}">
  <i class="iconfont icon-renzheng" title="Fly社区认证"></i>
  <h1>
    ${user.name}
    <!--<i class="iconfont icon-nan"></i>-->
    <!-- <i class="iconfont icon-nv"></i>  -->
  </h1>

  <p style="padding: 10px 0; color: #5FB878;">认证信息：
    <c:if test="${user.role == 1}">
      学生
    </c:if>
    <c:if test="${user.role == 2}">
      教师
    </c:if>
    <c:if test="${user.role == 3}">
      管理员
    </c:if>
  </p>

  <p class="fly-home-sign">（人生仿若一场修行）</p>

  <div class="fly-sns" data-user="">
<%--    <a href="javascript:;" class="layui-btn layui-btn-primary fly-imActive" data-type="addFriend">加为好友</a>--%>
    <a href="javascript:;" class="layui-btn layui-btn-normal fly-imActive" data-type="chat" data-role="${user.role}" data-id="${user.id}" data-name="${user.name}">发起会话</a>
  </div>

</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md6 fly-home-jie">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.name} 最近发帖</h3>
        <ul class="jie-row">
          <c:choose>
            <c:when test="${postList != null && postList.size() > 0}">
              <c:forEach items="${postList}" var="post">
                <li>
                  <c:if test="${post.excellentFlag == 1}">
                    <span class="fly-jing">精</span>
                  </c:if>
                  <a href="${basePath}community/detail/${post.id}" class="jie-title">${post.title}</a>
                  <i>${post.createTime}</i>
                  <em class="layui-hide-xs">${post.replyCount}回复</em>
                </li>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i style="font-size:14px;">没有发表任何帖子</i></div>
            </c:otherwise>
          </c:choose>
        </ul>
      </div>
    </div>
    
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.name} 最近的回复</h3>
        <ul class="home-jieda">
          <c:choose>
            <c:when test="${replyList != null && replyList.size() > 0}">
              <c:forEach items="${replyList}" var="reply">
                <li>
                  <p>
                    <span>${reply.createTime}</span>
                    在<a href="${basePath}community/detail/${reply.postId}">${reply.postTitle}</a>中回复：
                  </p>
                  <div class="home-dacontent">
                    ${reply.content}
                  </div>
                </li>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回复任何帖子</span></div>
            </c:otherwise>
          </c:choose>
        </ul>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/community/buildFooter" />

</body>
</html>