<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>发表问题 编辑问题 公用</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="${basePath}layui/css/layui.css">
  <link rel="stylesheet" href="${basePath}fly/css/global.css">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<div class="layui-container fly-marginTop">
  <div class="fly-panel" pad20 style="padding-top: 5px;">
    <!--<div class="fly-none">没有权限</div>-->
    <div class="layui-form layui-form-pane">
      <div class="layui-tab layui-tab-brief" lay-filter="user">
        <ul class="layui-tab-title">
          <li class="layui-this">
            <c:choose>
              <c:when test="${post != null}">
                编辑帖子
              </c:when>
              <c:otherwise>
                发表新帖
              </c:otherwise>
            </c:choose>
          </li>
        </ul>
        <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
          <div class="layui-tab-item layui-show">
            <form action="${basePath}community/save" method="post">
              <div class="layui-row layui-col-space15 layui-form-item">
                <div class="layui-col-md3">
                  <label class="layui-form-label">所在话题</label>
                  <div class="layui-input-block">
                    <select lay-verify="required" name="topicId" lay-filter="column">
                      <option></option>
                      <c:forEach items="${topicList}" var="topic">
                        <option value="${topic.id}" <c:if test="${post != null && topic.id == post.topicId}"> selected </c:if> >${topic.topicName}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>
                <div class="layui-col-md9">
                  <label for="L_title" class="layui-form-label">标题</label>
                  <div class="layui-input-block">
                    <input type="text" id="L_title" name="title" <c:if test="${post != null}"> value="${post.title}" </c:if> required lay-verify="required" autocomplete="off" class="layui-input">
                    <c:if test="${post != null}">
                      <input type="hidden" name="id" value="${post.id}">
                    </c:if>
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <div class="layui-input-block">
                  <textarea id="L_content" name="content" required lay-verify="required" placeholder="详细描述" class="layui-textarea fly-editor" style="height: 260px;">
                    <c:if test="${post != null}"> ${post.content}</c:if>
                  </textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" lay-filter="*" lay-submit>立即发布</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/community/buildFooter" />

</body>
</html>