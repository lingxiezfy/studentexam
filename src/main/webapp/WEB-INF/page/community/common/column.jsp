<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<div class="fly-panel fly-column">
  <div class="layui-container">
    <ul class="layui-clear">
      <li class="layui-hide-xs <c:if test="${topic == 0}">layui-this</c:if> "><a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=0&excellent=0&orderBy=newest">首页</a></li>
      <li class="<c:if test="${topic == 1}">layui-this</c:if>"><a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=1&excellent=0&orderBy=newest">学习交流</a></li>
      <li class="<c:if test="${topic == 2}">layui-this</c:if>"><a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=2&excellent=0&orderBy=newest">校园生活</a></li>
      <li class="<c:if test="${topic == 3}">layui-this</c:if>"><a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=3&excellent=0&orderBy=newest">课后杂谈</a></li>
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><span class="fly-mid"></span></li> 
      
      <!-- 用户登入后显示 -->
      <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="${basePath}community/user/${userCommon.role}/${userCommon.id}/home?pageIndex=1&pageSize=10">我发表的贴</a></li>
    </ul> 
    
    <div class="fly-column-right layui-hide-xs"> 
<%--      <span class="fly-search"><i class="layui-icon"></i></span> --%>
      <a href="${basePath}community/toAdd" class="layui-btn">发表新帖</a>
    </div> 
    <div class="layui-hide-sm layui-show-xs-block" style="margin-top: -10px; padding-bottom: 10px; text-align: center;"> 
      <a href="${basePath}community/toAdd" class="layui-btn">发表新帖</a>
    </div> 
  </div>
</div>