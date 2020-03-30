<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath }tools/toaster/toaster.min.css">
    <link rel="BOOKMARK" href="${basePath }images/icon.png">
</head>
<body class="app sidebar-mini rtl">
<!-- 头部-->
<header class="app-header"><a class="app-header__logo" href="index.html">学习交流平台</a>
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                    aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
        <c:if test="${sessionScope.role == 2 || sessionScope.role == 3}">
            <%--          教师和系统管理员可以发布公告--%>
            <li>
                <a class="app-nav__item"
                   href="javascript:publicNotice('${sessionScope.role}','${sessionScope.user.id}')">
                    <i class="fa fa-flag fa-lg"></i> &nbsp;发布公告
                </a>
            </li>
        </c:if>
        <!-- User Menu-->
        <li class="dropdown">
            <a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu">
                <i class="fa fa-user fa-lg">${sessionScope.user.username}</i>
                <c:if test="${sessionScope.user.modified eq 0 }">
                    &nbsp;&nbsp;<span style="color:red">当前是初始密码，请尽快修改密码</span>
                </c:if>
            </a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
                <li><a class="dropdown-item" href="javascript:toEditPwd()"><i class="fa fa-user-circle-o fa-lg"></i>
                    修改密码</a></li>
                <li><a class="dropdown-item" href="${basePath }logOut"><i class="fa fa-sign-out fa-lg"></i> 退出</a></li>
            </ul>
        </li>
    </ul>
</header>
<!-- 左边菜单-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar" id="menu_bar">
    <ul class="app-menu">
        <c:forEach items="${menus }" var="menu">
            <li><a class="app-menu__item" href="javascript:changeMenu('${menu.url }')"><i
                    class="app-menu__icon fa ${menu.icon }"></i><span class="app-menu__label">${menu.name }</span></a>
            </li>
        </c:forEach>
    </ul>
</aside>
<!-- 页面主体内容 -->
<c:if test="${role==1}">
    <iframe name="pageFrame" id="pageFrame" src="student/toIndex" width="100%" height="633px" frameborder="0"></iframe>
</c:if>
<c:if test="${role==2}">
    <iframe name="pageFrame" id="pageFrame" src="teacher/toIndex" width="100%" height="633px" frameborder="0"></iframe>
</c:if>
<c:if test="${role==3}">
    <iframe name="pageFrame" id="pageFrame" src="adminManager/toIndex" width="100%" height="633px"
            frameborder="0"></iframe>
</c:if>
<script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/popper.min.js"></script>
<script type="text/javascript" src="${basePath }js/bootstrap-4.4.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/main.js"></script>
<script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
<script type="text/javascript" src="${basePath }tools/toaster/toaster.min.js"></script>
<script type="text/javascript" src="${basePath }js/mySocket.js"></script>
<script type="text/javascript">
    /* 切换菜单 */
    var changeMenu = function (url) {
        document.getElementById("pageFrame").src = '${basePath}' + url;
    };

    var toEditPwd = function () {
        layer.open({
            type: 2,//弹出iframe层
            title: '修改密码',
            area: ['500px', '380px'],
            content: '${basePath}toEditPwd',
            btn: '提交',
            skin: 'my-skin',
            yes: function (index, layero) {
                //调用弹出层页面js
                var iframeWin = window[layero.find('iframe')[0]['name']];
                iframeWin.toSubmit();
            }

        })
    };

    // 发布公告
    var publicNotice = function (userRole, userId) {
        layer.open({
            type: 2,
            title: "发布公告",
            area: ['500px', '330px'],
            fixed: false,
            content: '${basePath}notice/toPublish',
            btn: ['发布', '取消'],
            yes: function (index, layero) {
                // 获取弹出层中的form表单元素
                var formSubmit = layer.getChildFrame('.layui-form .layui-btn', index).click();
                // 获取表单中的提交按钮（在我的表单里第一个button按钮就是提交按钮，使用find方法寻找即可）
                // var submited = formSubmit.find('.layui-form .layui-btn')[0]
                // 触发点击事件，会对表单进行验证，验证成功则提交表单，失败则返回错误信息
                // submited.click();
            }
        });
    }
</script>
</body>
</html>