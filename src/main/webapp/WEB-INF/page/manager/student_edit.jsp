<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>学生编辑</title>
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
             	<!--重要：将修改对象的ID放到隐藏域中  -->
               <input type="hidden" name="id" value="${student.id }">
               <div class="form-group row">
                  <label class="control-label col-md-3" for="fkGrade"><span style="color:red;">*</span>选择年级</label>
                  <div class="col-md-8">
                  	<select class="form-control" id="fkGrade" name="fkGrade" onchange="clazzSelect2('fkGrade','fkMajor','fkClazz')">
                    	<option value = "">--请选择年级--</option>
                    	
                    </select>
                  </div>
               </div>
               <div class="form-group row">
                  <label class="control-label col-md-3" for="fkMajor"><span style="color:red;">*</span>选择专业</label>
                  <div class="col-md-8">
                  	<select class="form-control" id="fkMajor" name="fkMajor" onchange="clazzSelect2('fkGrade','fkMajor','fkClazz')">
                    	<option value = "">--请选择专业--</option>
                    	
                    </select>
                  </div>
               </div>
               <div class="form-group row">
                  <label class="control-label col-md-3" for="fkClazz"><span style="color:red;">*</span>选择班级</label>
                  <div class="col-md-8">
                  	<select class="form-control" id="fkClazz" name="fkClazz">
                    	<option value = "">--请选择班级--</option>
                    	
                    </select>
                  </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="username"><span style="color:red;">*</span>用户名</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="username" name="username" value="${student.username }" placeholder="请输入用户名">
                 </div>
               </div>
               <div class="form-group row">
                 <label class="control-label col-md-3" for="realname"><span style="color:red;">*</span>姓名</label>
                 <div class="col-md-8">
                   <input class="form-control" type="text" id="realname" name="realname" value="${student.realname }" placeholder="请输入姓名">
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
    	gradeSelectWithDefault("fkGrade",'${clazz.fkGrade}');
    	majorSelectWithDefault("fkMajor",'${clazz.fkMajor}');
    	clazzSelect("fkClazz",'${clazz.id}');
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
              fkClazz: {
                  required: true,
              },
              username: {
            	  required: true,
              },
              realname: {
            	  required: true,
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
              fkClazz: {
                  required: "班级不能为空",
              },
              username: {
            	  required: "用户名不能为空",
              },
              realname: {
            	  required: "姓名不能为空",
              }
          },
          /* 使ajax提交和表单验证同级，先进行表单验证，再提交页面 */
          submitHandler:function(){
        	  $.ajax({
        		  async:true,
        		  data:$("#myform").serialize(),	//获取form中的所有数据
        		  type:'post',
        		  url:'${basePath}adminManager/updateStudent',
        		  success:function(data){	//请求成功回调函数
        			  if(data == 'ok'){
        				  parent.layer.alert("修改成功",function(){
        					  window.parent.location.reload();
        				  });
        			  }else if(data=='exist'){
        				  parent.layer.alert("该账号已存在");
        			  }else{
        				  parent.layer.alert("系统异常，请联系管理员");
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
    	/* 根据年级和专业初始化班级下拉框 */
    function clazzSelect(fkClazz,selectedId){
        var gradeId = '${clazz.fkGrade}';
        var majorId = '${clazz.fkMajor}'
        if(gradeId!=null&&gradeId!=''&&gradeId!=undefined
            && majorId!=null&&majorId!=''&&majorId!=undefined){
            $("#"+fkClazz).html("<option value = ''>--请选择班级--</option>");
            $.ajax({
                type:'post',
                url:basePath+'common/getClazzAll',
                data:{"gradeId":gradeId,"majorId":majorId},
                dataType:'json',
                success:function(data){
                    if(data!=null && data.length>0){
                        for(var i=0;i<data.length;i++){
                            if(data[i].id==selectedId){
                                $("#"+fkClazz).append("<option value='"+data[i].id+"' selected>"+data[i].cno+"</option>");
                            }else{
                                $("#"+fkClazz).append("<option value='"+data[i].id+"'>"+data[i].cno+"</option>");
                            }
                        }
                    }
                }
            })
        }

    }

    /* 根据年级和专业初始化班级下拉框 */
    function clazzSelect2(fkGrade,fkMajor,selectId){
        var gradeId = $("#"+fkGrade).val();
        var majorId = $("#"+fkMajor).val();
        if(gradeId!=null&&gradeId!=''&&gradeId!=undefined
            && majorId!=null&&majorId!=''&&majorId!=undefined){
            $("#"+selectId).html("<option value = ''>--请选择班级--</option>");
            $.ajax({
                type:'post',
                url:basePath+'common/getClazzAll',
                data:{"gradeId":gradeId,"majorId":majorId},
                dataType:'json',
                success:function(data){
                    if(data!=null && data.length>0){

                        for(var i=0;i<data.length;i++){
                            $("#"+selectId).append("<option value='"+data[i].id+"'>"+data[i].cno+"</option>");
                        }
                    }
                }
            })
        }

    }
    	
	    function gradeSelectWithDefault(id,selectedId){
	    	$.ajax({
	    		type:'post',
	    		url:basePath+'common/getGradeAll',
	    		dataType:'json',
	    		success:function(data){
	    			if(data!=null && data.length>0){
	    				for(var i=0;i<data.length;i++){
	    					if(data[i].id==selectedId){
	    						$("#"+id).append("<option value='"+data[i].id+"' selected>"+data[i].name+"</option>");
	    					}else{
	    						$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	    					}
	    				}
	    			}
	    			
	    		}
	    		
	    	})
	    }
	    
	    function majorSelectWithDefault(id,selectedId){
	    	$.ajax({
	    		type:'post',
	    		url:basePath+'common/getMajorAll',
	    		dataType:'json',
	    		success:function(data){
	    			if(data!=null && data.length>0){
	    				for(var i=0;i<data.length;i++){
	    					if(data[i].id==selectedId){
	    						$("#"+id).append("<option value='"+data[i].id+"' selected>"+data[i].name+"</option>");
	    					}else{
	    						$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	    					}
	    				}
	    			}
	    			
	    		}
	    		
	    	})
	    }
    </script>
  </body>
</html>