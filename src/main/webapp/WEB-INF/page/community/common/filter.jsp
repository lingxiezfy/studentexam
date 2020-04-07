<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<div class="fly-panel-title fly-filter">
    <a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=${topic}&excellent=0&orderBy=${orderBy}"
       class="<c:if test="${excellent == 0}">layui-this</c:if>">综合</a>

    <span class="fly-mid"></span>
    <a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=${topic}&excellent=1&orderBy=${orderBy}"
       class="<c:if test="${excellent == 1}">layui-this</c:if>">
      精华
    </a>
    <span class="fly-filter-right layui-hide-xs">
    <a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=${topic}&excellent=${excellent}&orderBy=newest"
       class="<c:if test="${'newest'.equals(orderBy)}">layui-this</c:if>">
      按最新
    </a>
    <span class="fly-mid"></span>
    <a href="${basePath}community/list?pageIndex=1&pageSize=8&topic=${topic}&excellent=${excellent}&orderBy=hottest"
       class="<c:if test="${'hottest'.equals(orderBy)}">layui-this</c:if>">
      按热议
    </a>
  </span>
</div>