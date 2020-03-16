<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>班级管理</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  	
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>班级管理</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">管理员</li>
          <li class="breadcrumb-item active"><a href="#">班级管理</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           
           <div class="tile-body">
              <form class="row" action="${basePath }manager/clazz" method="post">
                <div class="form-group col-md-3">
                  <label class="control-label">年级：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="gradeName" name="gradeName" placeholder="请输入年级" value="${gradeName }">
                  </div>
                </div>
                <div class="form-group col-md-3">
                  <label class="control-label">专业：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="majorName" name="majorName" placeholder="请输入专业" value="${majorName }">
                  </div>
                </div>
                <div class="form-group col-md-4 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                  <button class="btn btn-primary" type="button" onclick="clazzAdd()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                </div>
              </form>
            </div>
            <form id="tabform">
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
              	<c:forEach items="${pageInfo.list }" var="clazz" varStatus="status">
                <tr id="tr${clazz.id }">
                  <td>${status.count }</td>
                  <td>${clazz.gradeName}</td>
                  <td>${clazz.majorName }</td>
                  <td>${clazz.cno }</td>
                  <td>
                  	<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="del('${clazz.id}')">删除</button>
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
            </form>
            <p:page action="manager/clazz"/>
          </div>
        </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
    <script type="text/javascript">
    	function del(cid){
    		layer.confirm('您确定要删除吗？',
    			{btn:['确定','取消']},//按钮
    			function(){//确定
    				$.ajax({
    					type:'post',
    					url:'${basePath}manager/delClazz/'+cid,
    					success:function(data){
    						if(data=='ok'){
    							$("#tr"+cid).remove();
    							layer.alert("删除成功！");
    						}else{
    							layer.alert("删除失败！");
    						}
    					}
    				})
    			},function(){})//取消
		}
    	//添加专业
    	function clazzAdd(){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'添加班级',
	    		area:['500px','350px'],
	    		content:'${basePath}manager/toAddClazz',
	    		btn:'添加',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
	    		}
	    	
	    	})
    	}
    	
    </script>
  </body>
</html>