<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>教师关联班级</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
  	<style type="text/css">
  		.app-content{
  			margin-left:0px;
  			margin-top:0px;
  		}
  	</style>
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content" >
      <div class="row" >
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           <div class="tile-body">
              <form class="row" action="${basePath }adminManager/clazz" method="post">
                <div class="form-group col-md-3">
                  <select class="form-control" id="fkGrade" name="fkGrade" onchange="clazzSelect('fkGrade','fkMajor','fkClazz')">
                     <option value = "">--请选择年级--</option>
                  </select>
                </div>
                <div class="form-group col-md-3">
                  <select class="form-control" id="fkMajor" name="fkMajor" onchange="clazzSelect('fkGrade','fkMajor','fkClazz')">
                    <option value = "">--请选择专业--</option>
                  </select>
                </div>
                <div class="form-group col-md-3">
                  <select class="form-control" id="fkClazz" name="fClazz">
                    <option value = "">--请选择班级--</option>
                  </select>
                </div>
                <div class="form-group col-md-3 align-self-end">
                  <button class="btn btn-primary" type="button" onclick="clazzAdd()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>年级</th>
                  <th>专业</th>
                  <th>班级</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${list }" var="tc" varStatus="status">
                <tr id="tr${tc.id }">
                  <td>${status.count }</td>
                  <td>${tc.gradeName}</td>
                  <td>${tc.majorName }</td>
                  <td>${tc.cno }</td>
                  <td>
                  	<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="del('${tc.id}')">删除</button>
                  </td>
                </tr>
              	</c:forEach>
              	<c:if test="${empty list }">
              		<tr align="center">
              			<td colspan="5">暂无记录</td>
              		</tr>
              	</c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript" src="${basePath }js/select.js"></script>
    <script type="text/javascript">
    	$(function(){
    		//年级和专业下拉框初始化
    		gradeSelect("fkGrade",'${basePath}');
        	majorSelect("fkMajor",'${basePath}');
    	})
    	
    	function del(tid){
    		layer.confirm('您确定要删除吗？',
    			{btn:['确定','取消']},//按钮
    			function(){//确定
    				$.ajax({
    					type:'post',
    					url:'${basePath}adminManager/delTeacherClazz/'+tid,
    					success:function(data){
    						if(data=='ok'){
    							$("#tr"+tid).remove();
    							layer.alert("删除成功！");
    						}else{
    							layer.alert("删除失败！");
    						}
    					}
    				})
    			},function(){})//取消
		}
    	//添加班级
    	function clazzAdd(){
    		var cid = $("#fkClazz").val();
    		var tid = '${tid}';
    		if(cid!=null && cid!='' && cid!= undefined){
    			$.ajax({
    	    		type:"post",
    	    		url:"${basePath}adminManager/teaClazzSelect",
    	    		data:{"fkTeacher":tid,"fkClazz":cid},
    	    		success:function(data){
    	    			if(data=='ok'){
    	    				layer.alert("添加成功",function(){
    	    					window.location.reload();
    	    				});
    	    			}
    	    			else if(data == 'exist'){
    	    				layer.alert("该班级已添加");
    	    			}else{
    	    				layer.alert("添加失败");
    	    			}
    	    		}
    	    	})
    		}else{
    			layer.alert("请选择班级");
    		}
	    	
    	}
    	
    	/* 根据年级和专业初始化班级下拉框 */
	    function clazzSelect(fkGrade,fkMajor,selectId){
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
    </script>
  </body>
</html>