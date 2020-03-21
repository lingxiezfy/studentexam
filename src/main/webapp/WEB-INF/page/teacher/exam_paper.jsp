<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>试卷管理</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  	
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>试卷管理</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">教师</li>
          <li class="breadcrumb-item active"><a href="#">试卷管理</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           
           <div class="tile-body">
              <form class="row" action="${basePath }teacher/examPaper" method="post">
                <div class="form-group col-md-4">
                  <label class="control-label">试卷名称：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="title" name="title" placeholder="请输入试卷名称" value="${title }">
                  </div>
                </div>
                <div class="form-group col-md-3 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                  <button class="btn btn-primary" type="button" onclick="add()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>试卷名称</th>
                  <th>适用班级</th>
                  <th>时长（分钟）</th>
                  <th>状态</th>
                  <th>切换状态</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${pageInfo.list }" var="exam" varStatus="status">
	                <tr id="tr${exam.id }">
	                  <td>${status.count }</td>
	                  <td>${exam.title}</td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${exam.fkStatus eq 3 }">
	                  			<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" disabled="disabled">显示</button>
	                  		</c:when>
	                  		<c:otherwise>
	                  			<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="showClazz('${exam.id}')">显示</button>
	                  		</c:otherwise>
	                  	</c:choose>
	                  	
	                  </td>
	                  <td>${exam.timeLimit }</td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${exam.fkStatus eq 1}">
	                  			未初始化
	                  		</c:when>
	                  		<c:when test="${exam.fkStatus eq 2}">
	                  			未运行
	                  		</c:when>
	                  		<c:when test="${exam.fkStatus eq 3}">
	                  			正在运行
	                  		</c:when>
	                  	</c:choose>
	                  </td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${exam.fkStatus eq 1}">
	                  			<button class="btn btn-success" type="button" style="height:30px;line-height:10px;" disabled="disabled" >开始运行</button>
	                  		</c:when>
	                  		<c:when test="${exam.fkStatus eq 2}">
	                  			<button class="btn btn-success" type="button" style="height:30px;line-height:10px;" onclick="toExamRunning('${exam.id}')">开始运行</button>
	                  		</c:when>
	                  		<c:when test="${exam.fkStatus eq 3}">
	                  			<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="toExamStop('${exam.id}')">立即停止</button>
	                  		</c:when>
	                  	</c:choose>
	                  </td>
	                  <td>
	                  	<c:if test="${exam.fkStatus eq 3}">
	                  		<button class="btn btn-primary" type="button" style="height:30px;line-height:10px;" disabled="disabled">试题</button>
	                  		<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" disabled="disabled">编辑</button>
	                  		<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" disabled="disabled">删除</button>
	                  	</c:if>
	                  	<c:if test="${exam.fkStatus ne 3}">
	                  		<button class="btn btn-primary" type="button" style="height:30px;line-height:10px;" onclick="showQuestions('${exam.id}')">试题</button>
	                  		<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="edit('${exam.id}')">编辑</button>
	                  		<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="del('${exam.id}')">删除</button>
	                  	</c:if>
	                  	
	                  </td>
	                </tr>
              	</c:forEach>
              	<c:if test="${empty pageInfo.list }">
              		<tr align="center">
              			<td colspan="7">暂无记录</td>
              		</tr>
              	</c:if>
              </tbody>
            </table>
              <p:page action="teacher/examPaper"/>
          </div>
        </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>

    <script type="text/javascript">
    	function del(eid){
    		layer.confirm('您确定要删除吗？',
    			{btn:['确定','取消']},//按钮
    			function(){//确定
    				$.ajax({
    					type:'post',
    					url:'${basePath}teacher/deleteExam/'+eid,
    					success:function(data){
    						if(data=='ok'){
    							$("#tr"+eid).remove();
    							layer.alert("删除成功！");
    						}else{
    							layer.alert("删除失败！");
    						}
    					}
    				})
    			},function(){})//取消
		}
    	//添加试卷
    	function add(){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'添加试卷',
	    		area:['550px','350px'],
	    		content:'${basePath}teacher/toAddPaper',
	    		btn:'添加',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
	    		}
	    	
	    	})
    	}
    	
    	function edit(eid){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'编辑试卷',
	    		area:['550px','280px'],
	    		content:'${basePath}teacher/toEditPaper/'+eid,
	    		btn:'修改',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
	    		}
	    	
	    	})
    	}
    	
    	/* 选择所属班级 */
    	function showClazz(eid){
    		layer.open({
	    		type:2,//弹出iframe层
	    		title:'所属班级',
	    		area:['800px','500px'],
	    		content:'${basePath}teacher/toSelectClazz/'+eid,
	    		skin:'my-skin',
	    	})
    	}
    	
    	/* 跳转到试卷题目列表页面*/
    	function showQuestions(eid){
    		window.location.href="${basePath}teacher/examQuestions/"+eid;
    	}

        /* 跳转到开始运行设置页面 */
        function toExamRunning(eid){
            layer.open({
                type:2,//弹出iframe层
                title:'设置运行',
                area:['500px','220px'],
                content:'${basePath}teacher/toExamRunning/'+eid,
                skin:'my-skin',
                btn:'添加',
                yes:function(index,layero){
                    //调用弹出层页面js
                    var iframeWin = window[layero.find('iframe')[0]['name']];
                    iframeWin.toSubmit();
                }
            })
        }

        function toExamStop(eid){
            layer.confirm('您确定要停止吗？',
                {btn:['确定','取消']},//按钮
                function(){//确定
                    $.ajax({
                        type:'post',
                        url:'${basePath}teacher/examStop/'+eid,
                        success:function(data){
                            if(data=='ok'){
                                layer.alert("试卷已停止运行",function(){
                                    window.location.reload();
                                });
                            }else{
                                layer.alert("试卷关停失败");
                            }
                        }
                    })
                },function(){})//取消
        }
    </script>
  </body>
</html>