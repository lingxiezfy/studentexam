<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>提交作业</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-th-list"></i>提交作业</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">学生</li>
          <li class="breadcrumb-item active"><a href="#">提交作业</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>作业名称</th>
                  <th>状态</th>
                  <th>结束时间</th>
                  <th>提交状态</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${works }" var="work" varStatus="status">
                <tr>                  
                  <td>${status.count }</td>
                  <td><a href="javascript:working('${work.id }')" >${work.title}</a></td>
                  <td>${work.status}</td>
                  <td>${work.endTime }</td>
                  <td>
                    <c:choose>
                      <c:when test="${work.submitFile == null}">
                        未提交
                      </c:when>
                      <c:otherwise>
                        已提交(可修改)
                      </c:otherwise>
                    </c:choose>

                  </td>
                  <td>
                    <a href="javascript:working('${work.id }')" >查看练习</a>
                  </td>
                </tr>
              	</c:forEach>
              	<c:if test="${empty works }">
              		<tr align="center">
              			<td colspan="4">暂无考试</td>
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
    	function working(eid){
    		var tempwindow=window.open('_blank');
    		tempwindow.location='${basePath}student/working/'+eid;
    	}
    </script>
  </body>
</html>