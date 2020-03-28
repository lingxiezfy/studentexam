<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
  <head>
    <title>首页</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="BOOKMARK" href="${basePath }images/icon.png">
  </head>
  <body class="app sidebar-mini rtl">
    <!-- 头部-->
    <header class="app-header"><a class="app-header__logo" href="index.html">学习交流平台</a>
      <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
      <!-- Navbar Right Menu-->
      <ul class="app-nav">
        <!-- User Menu-->
        <li class="dropdown">
          <a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu">
            <i class="fa fa-user fa-lg">${sessionScope.user.username}</i>
        	<c:if test="${sessionScope.user.modified eq 0 }">
        		&nbsp;&nbsp;<span style="color:red">当前是初始密码，请尽快修改密码</span>
        	</c:if>
          </a>
          <ul class="dropdown-menu settings-menu dropdown-menu-right">
            <li><a class="dropdown-item" href="javascript:toEditPwd()"><i class="fa fa-user-circle-o fa-lg"></i> 修改密码</a></li>
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
      		<li><a class="app-menu__item" href="javascript:changeMenu('${menu.url }')"><i class="app-menu__icon fa ${menu.icon }"></i><span class="app-menu__label">${menu.name }</span></a></li>
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
      <iframe name="pageFrame" id="pageFrame" src="manager/toIndex" width="100%" height="633px" frameborder="0"></iframe>
    </c:if>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/popper.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap-4.4.1.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>--%>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript">
    	/* 切换菜单 */
    	var changeMenu = function(url){
    		document.getElementById("pageFrame").src = '${basePath}'+url;
    	}
    	
    	var toEditPwd = function(){
    		layer.open({
	    		type:2,//弹出iframe层
	    		title:'修改密码',
	    		area:['500px','380px'],
	    		content:'${basePath}toEditPwd',
	    		btn:'提交',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
	    		}
	    	
	    	})
    	}
    </script>
  </body>
</html>