<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>班级添加</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/form.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content" style="margin-top:0px;margin-bottom:0px;padding:10px;padding-bottom:0px">
      <div class="row">
      	<div class="col-md-12">
         <div class="tile" style="padding-bottom: 8px">
           <div class="tile-body">
             <form class="form-horizontal" id="myform">
               <div class="form-group row">
                  <label class="control-label col-md-3" for="fkGrade"><span style="color:red;">*</span>选择年级</label>
                  <div class="col-md-8">
                  	<select class="form-control" id="fkGrade" name="fkGrade">
                    	<option value = "">--请选择年级--</option>

                    </select>
                  </div>
               </div>
               <div class="form-group row">
                  <label class="control-label col-md-3" for="fkMajor"><span style="color:red;">*</span>选择专业</label>
                  <div class="col-md-8">
                  	<select class="form-control" id="fkMajor" name="fkMajor">
                    	<option value = "">--请选择专业--</option>
                    	
                    </select>
                  </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="cno"><span style="color:red;">*</span>班级编号</label>
                 <div class="col-md-8">
                   <input class="form-control" type="number" id="cno" name="cno" placeholder="请输入班级编号">
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
    <script type="text/javascript" src="${basePath }js/select.js"></script>
    <script type="text/javascript">
    
    $(function() {
    	//初始化下拉框
    	gradeSelect("fkGrade",'${basePath}');
    	majorSelect("fkMajor",'${basePath}');
    	
    	//表单验证
        $("#myform").validate({
          //验证规则
          rules: {
        	  fkGrade: {
                  required: true,
              },
              fkMajor: {
                  required: true,
              },
              cno: {
                  required: true,
                  digits:true
              }
          },
		  //提示信息
          messages: {
        	  fkGrade: {
                  required: "年级不能为空",
              },
              fkMajor: {
                  required: "专业不能为空",
              },
              cno: {
                  required: "班级编号不能为空",
                  digits: "必须输入整数"
              }
          },
          /* 使ajax提交和表单验证同级，先进行表单验证，再提交页面 */
          submitHandler:function(){
        	  $.ajax({
        		  async:true,
        		  data:$("#myform").serialize(),	//获取form中的所有数据
        		  type:'post',
        		  url:'${basePath}manager/saveClazz',
        		  success:function(data){	//请求成功回调函数
        			  if(data == 'ok'){
        				  parent.layer.alert("添加成功",function(){
        					  window.parent.location.reload();
        				  });
        			  }else if(data=='exist'){
        				  parent.layer.alert("该班级已存在");
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