<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>教师添加</title>
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
                 <label class="control-label col-md-3" for="username"><span style="color:red;">*</span>用户名</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="username" name="username" placeholder="请输入用户名">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="realname"><span style="color:red;">*</span>姓名</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="realname" name="realname" placeholder="请输入姓名">
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
        	  username: "required",
        	  realname: "required"
          },
		  //提示信息
          messages: {
        	  username: "用户名不能为空",
        	  realname: "姓名不能为空"
          },
          /* 使ajax提交和表单验证同级，先进行表单验证，再提交页面 */
          submitHandler:function(){
        	  $.ajax({
        		  data:$("#myform").serialize(),	//获取form中的所有数据
        		  type:'post',
        		  url:'${basePath}adminManager/saveTeacher',
        		  success:function(data){	//请求成功回调函数
        			  if(data == 'ok'){
        				  parent.layer.alert("添加成功",function(){
        					  window.parent.location.reload();
        				  });
        			  }else if(data=='exist'){
        				  parent.layer.alert("该教师已存在");
        			  }else{
        				  parent.layer.alert("添加失败");
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