<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>考试记录</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>考试记录</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">学生</li>
          <li class="breadcrumb-item active"><a href="#">考试记录</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
          	<div class="tile-body">
              <form class="row" action="${basePath }student/examHistory" method="post">
                <div class="form-group col-md-4">
                  <label class="control-label">试卷名称：</label>
                  <div class="btn-group" data-toggle="buttons">
                  	<input class="form-control" type="text" id="title" name="title" placeholder="请输入试卷名称" value="${title }">
                  </div>
                </div>
                <div class="form-group col-md-4 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>试卷名称</th>
                  <th>得分</th>
                  <th>考试时间</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${pageInfo.list }" var="exam" varStatus="status">
                <tr>                  
                  <td>${status.count }</td>
                  <td><a href="javascript:history('${exam.id }','${exam.fkExam }')">${exam.examTitle}</a></td>
                  <td>${exam.point}</td>
                  <td>${exam.time }</td>
                </tr>
              	</c:forEach>
              	<c:if test="${empty pageInfo.list }">
              		<tr align="center">
              			<td colspan="4">暂无记录</td>
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
    <script type="text/javascript" src="${basePath }js/page.js"></script>
    <script type="text/javascript">
    	function history(examResultId,examId){
    		var tempwindow=window.open('_blank');
    		tempwindow.location='${basePath}student/toHistory?examResultId='+examResultId+"&examId="+examId;
    	}
    	
    	
    </script>
  </body>
</html>