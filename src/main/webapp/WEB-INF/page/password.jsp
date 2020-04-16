<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>修改密码</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/form.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content" style="margin-top:0px;margin-bottom:0px;padding:10px;padding-bottom:0px">
      <div class="row">
      	<div class="col-md-12">
         <div class="tile" style="padding-bottom: 8px">
           <div class="tile-body">
             <form class="form-horizontal" id="myform">
               <div class="form-group row">
                 <label class="control-label col-md-4" for="oldPwd"><span style="color:red;">*</span>原密码</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="oldPwd" name="oldPwd" value="" style="width:80%" placeholder="请输入原密码">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-4" for="newPwd"><span style="color:red;">*</span>新密码</label>
                 <div class="col-md-8">
                   <input class="form-control" type="password" id="newPwd" name="newPwd" value="" style="width:80%" placeholder="请输入6-18位新密码">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-4" for="rePwd"><span style="color:red;">*</span>确认密码</label>
                 <div class="col-md-8">
                   <input class="form-control" type="password" id="rePwd" name="rePwd" value="" style="width:80%" placeholder="请输入再次密码">
                 </div>
               </div>
             </form>
           </div>
         </div>
       </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript" src="${basePath }js/jquery.validate.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript">
    $(function() {
    	
      $("#myform").validate({
    	  //验证规则
          rules: {
        	  oldPwd: {
                  required: true,
              },
              newPwd: {
                  required: true,
                  rangelength: [6,18]
              },
              rePwd: {
                  required: true,
                  rangelength: [6,18],
                  equalTo: "#newPwd"
              }
          },
		  //提示信息
          messages: {
        	  oldPwd: {
                  required: "原密码不能为空",
              },
              newPwd: {
                  required: "新密码不能为空",
                  rangelength:"密码长度为6-18位"
              },
              rePwd: {
                  required: "确认密码不能为空",
                  rangelength:"密码长度为6-18位",
                  equalTo: "两次密码不一致"
              }
          },
          /* 使ajax提交和表单验证同级，先进行表单验证，再提交页面 */
          submitHandler:function(){
        	  $.ajax({
        		  async:true,
        		  data:$("#myform").serialize(),	//获取form中的所有数据
        		  type:'post',
        		  url:'${basePath}updatePwd',
        		  success:function(data){	//请求成功回调函数
        			  if(data == 'ok'){
        				  parent.layer.alert("修改成功，请重新登录",function(){
        					  window.parent.location.href="${basePath}logOut";
        				  });
        			  }else if(data=='old_error'){
        				  parent.layer.alert("原密码错误");
        			  }else{
        				  parent.layer.alert("修改失败");
        			  }
        		  }
        	  });
          }
      })
  })
  	
  	/* 提交表单 */
  	function toSubmit(){
    	$("#myform").submit();
    }
    </script>
  </body>
</html>