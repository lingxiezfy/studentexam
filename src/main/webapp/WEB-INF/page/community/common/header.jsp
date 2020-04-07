<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" href="${basePath}community/list?topic=0">
            <img src="${basePath}fly/images/logo.png" alt="校园社区">
        </a>
        <ul class="layui-nav fly-nav layui-hide-xs">
            <li class="layui-nav-item layui-this">
                <a href="${basePath}community/list?topic=0"><i class="iconfont icon-jiaoliu"></i>社区首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="${basePath}index"><i class="iconfont icon-iconmingxinganli"></i>返回学习中心</a>
            </li>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <!-- 登入后的状态 -->
            <li class="layui-nav-item">
                <a class="fly-nav-avatar" href="javascript:;">
                    <cite class="layui-hide-xs">${userCommon.name}</cite>
                    <img src="${basePath}fly/images/avatar/default.png">
                </a>
                <dl class="layui-nav-child">
                    <%--<dd><a href="user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>--%>
                    <dd><a href="${basePath}community/user/${userCommon.role}/${userCommon.id}/home?pageIndex=1&pageSize=10"><i class="layui-icon"
                                                                    style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>用户中心</a>
                    </dd>
                    <dd><a href="${basePath}community/user/${userCommon.role}/${userCommon.id}/index"><i class="layui-icon">&#xe612;</i>我的主页</a></dd>

                    <%--<hr style="margin: 5px 0;">--%>
                    <%--<dd><a href="/user/logout/" style="text-align: center;">退出</a></dd>--%>
                </dl>
            </li>
        </ul>
    </div>
</div>