<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>作业管理</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
  	
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>作业管理</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">教师</li>
          <li class="breadcrumb-item active"><a href="#">作业管理</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           
           <div class="tile-body">
              <form class="row" action="${basePath }teacher/workPaper" method="post">
                <div class="form-group col-md-4">
                  <label class="control-label">作业名称：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="title" name="title" placeholder="请输入作业名称" value="${title }">
                  </div>
                </div>
                <div class="form-group col-md-3 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                  <button class="btn btn-primary" type="button" onclick="add()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered" style="font-size: 15px">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>作业名称</th>
                  <th>作业内容</th>
                  <th>适用班级</th>
                  <th>时长（分钟）</th>
                  <th>状态</th>
                  <th>切换状态</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${pageInfo.list }" var="work" varStatus="status">
	                <tr id="tr${work.id }">
	                  <td>${status.count }</td>
	                  <td>${work.title}</td>
                        <td><textarea>${work.content}</textarea></td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${work.fkStatus eq 3 }">
	                  			<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" disabled="disabled">显示</button>
	                  		</c:when>
	                  		<c:otherwise>
	                  			<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="showClazz('${work.id}')">显示</button>
	                  		</c:otherwise>
	                  	</c:choose>
	                  	
	                  </td>
	                  <td>${work.timeLimit }</td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${work.fkStatus eq 1}">
                                未运行
	                  		</c:when>
	                  		<c:when test="${work.fkStatus eq 2}">
	                  			未运行
	                  		</c:when>
	                  		<c:when test="${work.fkStatus eq 3}">
	                  			正在运行
	                  		</c:when>
                            <c:when test="${work.fkStatus eq 4}">
                                已结束
                            </c:when>
	                  	</c:choose>
	                  </td>
	                  <td>
	                  	<c:choose>
	                  		<c:when test="${work.fkStatus eq 1}">
                                <button class="btn btn-success" type="button" style="height:30px;line-height:10px;" onclick="toWorkRunning('${work.id}')">开始运行</button>
	                  		</c:when>
	                  		<c:when test="${work.fkStatus eq 2}">
	                  			<button class="btn btn-success" type="button" style="height:30px;line-height:10px;" onclick="toWorkRunning('${work.id}')">开始运行</button>
	                  		</c:when>
	                  		<c:when test="${work.fkStatus eq 3}">
	                  			<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="toWorkStop('${work.id}')">立即停止</button>
	                  		</c:when>
                            <c:when test="${work.fkStatus eq 4}">
                                <button class="btn btn-warning" type="button" style="height:30px;line-height:10px;" onclick="toReview('${work.id}')">作业批改</button>
                            </c:when>
	                  	</c:choose>
	                  </td>
	                  <td>
	                  	<c:if test="${work.fkStatus eq 3}">
	                  		<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" disabled="disabled">编辑</button>
	                  		<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" disabled="disabled">删除</button>
	                  	</c:if>
	                  	<c:if test="${work.fkStatus ne 3}">
	                  		<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="edit('${work.id}')">编辑</button>
	                  		<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="del('${work.id}')">删除</button>
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
              <p:page action="teacher/workPaper"/>
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
    					url:'${basePath}teacher/deleteWork/'+eid,
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
    	//添加作业
    	function add(){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'添加作业',
	    		area:['550px','380px'],
	    		content:'${basePath}teacher/toAddWorkPaper',
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
	    		title:'编辑作业',
	    		area:['550px','380px'],
	    		content:'${basePath}teacher/toEditWorkPaper/'+eid,
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
	    		content:'${basePath}teacher/toSelectWorkClazz/'+eid,
	    		skin:'my-skin',
	    	})
    	}
    	
    	/* 跳转到作业题目列表页面*/
    	function showQuestions(eid){
    		window.location.href="${basePath}teacher/workQuestions/"+eid;
    	}

        /* 跳转到开始运行设置页面 */
        function toWorkRunning(eid){
            layer.open({
                type:2,//弹出iframe层
                title:'设置运行',
                area:['500px','220px'],
                content:'${basePath}teacher/toWorkRunning/'+eid,
                skin:'my-skin',
                btn:'添加',
                yes:function(index,layero){
                    //调用弹出层页面js
                    var iframeWin = window[layero.find('iframe')[0]['name']];
                    iframeWin.toSubmit();
                }
            })
        }

        function toWorkStop(eid){
            layer.confirm('您确定要停止吗？',
                {btn:['确定','取消']},//按钮
                function(){//确定
                    $.ajax({
                        type:'post',
                        url:'${basePath}teacher/workStop/'+eid,
                        success:function(data){
                            if(data=='ok'){
                                layer.alert("作业已停止运行",function(){
                                    window.location.reload();
                                });
                            }else{
                                layer.alert("作业关停失败");
                            }
                        }
                    })
                },function(){})//取消
        }

        function toReview(workId) {
            var tempwindow=window.open('_blank');
            tempwindow.location='/teacher/toReview/'+workId;
        }
    </script>
  </body>
</html>