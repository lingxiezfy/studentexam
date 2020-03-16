<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>教师管理</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  	
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>教师管理</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">管理员</li>
          <li class="breadcrumb-item active"><a href="#">教师管理</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           
           <div class="tile-body">
              <form class="row" action="${basePath }manager/teaList" method="post">
                <div class="form-group col-md-3">
                  <label class="control-label">姓名：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="realname" name="realname" placeholder="请输入姓名" value="${realname }">
                  </div>
                </div>
                <div class="form-group col-md-3 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                  <button class="btn btn-primary" type="button" onclick="teacherAdd()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>用户名</th>
                  <th>姓名</th>
                  <th>班级</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${pageInfo.list }" var="tea" varStatus="status">
	                <tr id="tr${tea.id }">
	                  <td>${status.count }</td>
	                  <td>${tea.username}</td>
	                  <td>${tea.realname }</td>
	                  <td>
	                  	<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="showClazz('${tea.id}')">显示</button>
	                  </td>
	                  <td>
	                  	<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="edit('${tea.id}')">编辑</button>
	                  	<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="del('${tea.id}')">删除</button>
	                  </td>
	                </tr>
              	</c:forEach>
              	<c:if test="${empty pageInfo.list }">
              		<tr align="center">
              			<td colspan="5">暂无记录</td>
              		</tr>
              	</c:if>
              </tbody>
            </table>
              <p:page action="manager/teaList"/>
          </div>
        </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript">
    	function del(tid){
    		layer.confirm('您确定要删除吗？',
    			{btn:['确定','取消']},//按钮
    			function(){//确定
    				$.ajax({
    					type:'post',
    					url:'${basePath}manager/deleteTeacher/'+tid,
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
    	//添加教师
    	function teacherAdd(){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'添加教师',
	    		area:['500px','280px'],
	    		content:'${basePath}manager/toAddTeacher',
	    		btn:'添加',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
	    		}
	    	
	    	})
    	}
    	
    	function edit(tid){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'编辑教师',
	    		area:['500px','280px'],
	    		content:'${basePath}manager/toEditTeacher/'+tid,
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
    	function showClazz(tid){
    		layer.open({
	    		type:2,//弹出iframe层
	    		title:'所属班级',
	    		area:['800px','500px'],
	    		content:'${basePath}manager/toSelectClazz/'+tid,
	    		skin:'my-skin',
	    	})
    	}
    </script>
  </body>
</html>