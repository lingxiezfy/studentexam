<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
  <head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/font-awesome.min.css">
    <!-- 书签图标 -->
    <link rel="BOOKMARK" href="${basePath }images/icon.png">
    <title>"我的课堂"学习交流平台登录</title>
    <style>
		.error{
			color:red !important;
		}
		
	</style>
  </head>
  <body>
    <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="login-content">
      <div class="logo">
        <h1>"我的课堂"学习交流平台</h1>
      </div>
      <div class="login-box">
        <form class="login-form" id="myform">
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>登录</h3>
          <div class="form-group">
            <label class="control-label">用户名</label>&nbsp;&nbsp;&nbsp;&nbsp;<span id="error1"></span>
            <input class="form-control" type="text" id="username" name="username" value="admin" placeholder="请输入用户名" autofocus>
          </div>
          <div class="form-group">
            <label class="control-label">密码</label>&nbsp;&nbsp;&nbsp;&nbsp;<span id="error2"></span>
            <input class="form-control" type="password" id="password" name="password" value="111111" placeholder="请输入密码">
          </div>
          <div class="form-group">
          	<div class="animated-radio-button">
              <label>
                <input type="radio" name="role" value="1"><span class="label-text">学生</span>
              </label>
              <label>
                <input type="radio" name="role" value="2"><span class="label-text">教师</span>
              </label>
              <label>
                <input type="radio" name="role" value="3" checked="checked"><span class="label-text">管理员</span>
              </label>
            </div>
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block" type="submit"><i class="fa fa-sign-in fa-lg fa-fw"></i>登录</button>
          </div>
        </form>
      </div>
    </section>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/jquery-validation/dist/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript">
	    $("#myform").validate({
	    	errorPlacement: function(error, element) {
	    		if(error.html() == '用户名不能为空')
	    	    	error.appendTo("span[id='error1']");  
	    		if(error.html() == '密码不能为空')
	    	    	error.appendTo("span[id='error2']");
	    	},
	    	rules:{
				username:"required",
				password:"required",
			},
			messages:{
				username:"用户名不能为空",
				password:"密码不能为空"
			},
			submitHandler:function(){
				$.ajax({
					type:"post",
					url:"${basePath}doLogin",
					data:$("#myform").serialize(),
					success:function(data){
						if(data=='ok'){
							window.location.href="${basePath}index";
						}else if(data == 'wrong'){
                          layer.alert("用户名或密码错误");
                        }else if(data=='error'){
							layer.alert("系统异常，请联系管理员");
						}else{
							layer.alert(data);
						}
						
					}
				})
			}
		})
    </script>
  </body>
</html>