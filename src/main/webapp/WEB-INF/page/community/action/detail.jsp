<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${post.title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${basePath}layui/css/layui.css">
  <link rel="stylesheet" href="${basePath}fly/css/global.css">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="layui-hide-xs">
  <jsp:include page="../common/column.jsp" />
</div>

<div class="layui-container">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1>${post.title}</h1>
        <div class="fly-detail-info">
          <c:if test="${post.topFlag == 1}">
            <span class="layui-badge layui-bg-black">置顶</span>
          </c:if>
          <c:if test="${post.excellentFlag == 1}">
            <span class="layui-badge layui-bg-red">精帖</span>
          </c:if>
          
          <div class="fly-admin-box" data-id="${post.id}">
            <!-- 可管理 或者是自己的文章 -->
            <c:if test="${post.userRole == 3 || (userCommon.role == post.userRole && userCommon.id == post.userId)}">
              <span class="layui-btn layui-btn-xs jie-admin" type="del">删除</span>
            </c:if>
            <c:if test="${userCommon.role == 3}">
              <c:choose>
                <c:when test="post.topFlag == 1">
                  <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="0" style="background-color:#ccc;">取消置顶</span>
                </c:when>
                <c:otherwise>
                  <span class="layui-btn layui-btn-xs jie-admin" type="set" field="stick" rank="1">置顶</span>
                </c:otherwise>
              </c:choose>
              <c:choose>
                <c:when test="${post.excellentFlag == 1}">
                  <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="0" style="background-color:#ccc;">取消加精</span>
                </c:when>
                <c:otherwise>
                  <span class="layui-btn layui-btn-xs jie-admin" type="set" field="status" rank="1">加精</span>
                </c:otherwise>
              </c:choose>
            </c:if>
          </div>
          <span class="fly-list-nums"> 
            <a href="#comment"><i class="iconfont" title="回复">&#xe60c;</i> ${post.replyCount}</a>
          </span>
        </div>
        <div class="detail-about">
          <a href="${basePath}community/user/${post.userRole}/${post.userId}/index" class="fly-avatar">
            <img src="${basePath}fly/images/avatar/default.png" alt="${post.userName}">
          </a>
          <div class="fly-detail-user">
            <a href="${basePath}community/user/${post.userRole}/${post.userId}/index" class="fly-link">
              <cite>${post.userName}</cite>
            </a>
            <span>${post.createTime}</span>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin" data-id="${post.id}">
            <c:if test="${post.userRole == 1 }">
              学生
            </c:if>
            <c:if test="${post.userRole == 2 }">
              教师
            </c:if>
            <c:if test="${post.userRole == 3 }">
              管理员
            </c:if>
            <c:if test="${userCommon.role == post.userRole && userCommon.id == post.userId}">
                <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a href="${basePath}community/toEdit/${post.id}">编辑此贴</a></span>
            </c:if>
          </div>
        </div>
        <div class="detail-body photos">
          <p>${post.content}</p>
        </div>
        <div id="replyBegin"></div>
      </div>
      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>回帖</legend>
        </fieldset>
        <ul class="jieda" id="jieda">
          <c:choose>
            <c:when test="${replyList != null && replyList.size() > 0}">
              <c:forEach items="${replyList}" var="reply">
                <li data-id="${reply.id}" class="jieda-daan">
                  <a name="item-${reply.id}"></a>
                  <div class="detail-about detail-about-reply">
                    <a class="fly-avatar" href="${basePath}community/user/${reply.userRole}/${reply.userId}/index">
                      <img src="${basePath}fly/images/avatar/default.png" alt="${reply.userName}">
                    </a>
                    <div class="fly-detail-user">
                      <a href="${basePath}community/user/${reply.userRole}/${reply.userId}/index" class="fly-link">
                        <cite>${reply.userName}</cite>
                      </a>
                      <c:if test="${reply.userRole == post.userRole && reply.userId == post.userId}">
                        <span>(楼主)</span>
                      </c:if>
                      <c:if test="${reply.userRole == 3}">
                        <span style="color:#5FB878">(管理员)</span>
                      </c:if>
                    </div>

                    <div class="detail-hits">
                      <span>${reply.createTime}</span>
                    </div>
                  </div>
                  <div class="detail-body jieda-body photos">
                    ${reply.content}
                  </div>
                  <div class="jieda-reply">
                    <span type="reply">
                      <i class="iconfont icon-svgmoban53"></i>
                      回复
                    </span>
                    <div class="jieda-admin">
                      <!-- 本人的回复 -->
                      <c:if test="${userCommon.role == reply.userRole && userCommon.id == reply.userId}">
                        <span type="edit">编辑</span>
                      </c:if>
                      <!-- 本人的回复 或楼主 或管理员 -->
                      <c:if test="${(userCommon.role == reply.userRole && userCommon.id == reply.userId) || userCommon.role == 3 || (userCommon.role == post.userRole && userCommon.id == post.userId)}">
                        <span type="del">删除</span>
                      </c:if>
                    </div>
                  </div>
                </li>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <li class="fly-none">消灭零回复</li>
            </c:otherwise>
          </c:choose>
        </ul>
        <div style="text-align: center">
          <div id="page-view"></div>
        </div>
        <a href="" id="PageJump"></a>
        
        <div class="layui-form layui-form-pane">
          <form action="${basePath}community/saveReply" method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <textarea id="L_content" name="content" required lay-verify="required" placeholder="请输入内容"  class="layui-textarea fly-editor" style="height: 150px;"></textarea>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="postId" value="${post.id}">
              <button class="layui-btn" lay-filter="json" lay-submit>提交回复</button>
            </div>
          </form>
        </div>
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

<jsp:include page="../common/footer.jsp" />

<script>
layui.use(['fly', 'face','laypage','jie'], function(){
  var $ = layui.$
          ,fly = layui.fly
          ,laypage = layui.laypage;

  //执行一个laypage实例
  laypage.render({
    elem: 'page-view' //注意，这里的 test1 是 ID，不用加 # 号
    , count: ${totalCount} //数据总数，从服务端得到
    , curr: ${currPage}
    , limit: ${pageSize}
    , groups:3
    ,jump: function(obj, first){
      if(!first){
        $("#PageJump").attr('href','${basePath}community/detail/${post.id}?pageIndex='+obj.curr+'&pageSize='+obj.limit+'#replyBegin')
        $("#PageJump")[0].click();
      }
    }
  });
  //提交成功后刷新
  fly.form['${basePath}community/saveReply'] = function(data, required){
    layer.msg('成功', {
      icon: 1
      ,time: 1000
      ,shade: 0.1
    }, function(){
      location.reload();
    });
  }


});
</script>

</body>
</html>