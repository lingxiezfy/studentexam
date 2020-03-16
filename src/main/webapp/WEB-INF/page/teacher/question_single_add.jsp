<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>添加单选题</title>
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
                 <label class="control-label col-md-3" for="title"><span style="color:red;">*</span>题目</label>
                 <div class="col-md-8">
                   <textarea class="form-control" id="title" name="title" rows="3"></textarea>
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="optiona"><span style="color:red;">*</span>A</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="optiona" name="optiona">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="optionb"><span style="color:red;">*</span>B</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="optionb" name="optionb">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="optionc"><span style="color:red;">*</span>C</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="optionc" name="optionc">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="optiond"><span style="color:red;">*</span>D</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="optiond" name="optiond">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3"><span style="color:red;">*</span>答案</label>
                 <div class="col-md-8">
                   <div class="animated-radio-button">
		              <label>
		                <input type="radio" name="answer" value="A"><span class="label-text">A</span>
		              </label>
		              &nbsp;&nbsp;&nbsp;&nbsp;
		              <label>
		                <input type="radio" name="answer" value="B"><span class="label-text">B</span>
		              </label>
		              &nbsp;&nbsp;&nbsp;&nbsp;
		              <label>
		                <input type="radio" name="answer" value="C"><span class="label-text">C</span>
		              </label>
		              &nbsp;&nbsp;&nbsp;&nbsp;
		              <label>
		                <input type="radio" name="answer" value="D"><span class="label-text">D</span>
		              </label>
		            </div>
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="score"><span style="color:red;">*</span>分值</label>
                 <div class="col-md-8">
                   <input class="form-control" type="number" id="score" name="score">
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
        	  title: "required",
        	  optiona: "required",
        	  optionb: "required",
        	  optionc: "required",
        	  optiond: "required",
        	  answer: "required",
        	  score: {
        		  required:true,
        		  number:true
        	  },
          },
		  //提示信息
          messages: {
        	  title: "题目不能为空",
        	  optiona: "选项A不能为空",
        	  optionb: "选项B不能为空",
        	  optionc: "选项C不能为空",
        	  optiond: "选项D不能为空",
        	  answer: "答案不能为空",
        	  score: {
        		  required:"分值不能为空",
        		  number:"分值必须为数字"
        	  },
          },
          /* 使ajax提交和表单验证同级，先进行表单验证，再提交页面 */
          submitHandler:function(){
        	  $.ajax({
        		  data:$("#myform").serialize(),	//获取form中的所有数据
        		  type:'post',
        		  url:'${basePath}teacher/saveSingle',
        		  success:function(data){	//请求成功回调函数
        			  if(data == 'ok'){
        				  parent.layer.alert("添加成功",function(){
        					  window.parent.location.reload();
        				  });
        			  }else if(data=='exist'){
        				  parent.layer.alert("该题目已存在");
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