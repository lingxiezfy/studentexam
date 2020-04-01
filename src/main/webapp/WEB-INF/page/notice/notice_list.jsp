<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>通知列表</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-th-list"></i>通知</h1>
        </div>
    </div>
    <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
            <div class="tile">

                <div class="tile-body">
                    <form class="row" action="${basePath }notice/list" id="messageForm">
                        <input type="hidden" name="messageId" value="">
                        <div class="form-group col-md-2">
                            <label class="control-label">消息类型：</label>
                            <div class="btn-group" data-toggle="buttons">
                                <select class="form-control" id="messageType" name="messageType">
                                    <option value = "">--全部--</option>
                                    <option value = "1" <c:if test="${messageType == 1}"> selected </c:if> >--系统公告--</option>
                                    <option value = "2" <c:if test="${messageType == 2}"> selected </c:if> >--班级通知--</option>
                                </select>
                            </div>
                        </div>
                        <c:if test="${messageType != null && teacherList != null && messageType == 2 }">
                            <div class="form-group col-md-2">
                                <label class="control-label">老师：</label>
                                <div class="btn-group" data-toggle="buttons">
                                    <select class="form-control" id="teacherId" name="teacherId">
                                        <option value = "">--全部--</option>
                                        <c:forEach items="${teacherList}" var="teacher">
                                            <option value = "${teacher.id}" <c:if test="${teacherId == teacher.id}"> selected </c:if> >${teacher.realname}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </c:if>
                    </form>
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr align="center">
                        <th>序号</th>
                        <th>作者</th>
                        <th>标题</th>
                        <th>内容</th>
                    </tr>
                    </thead>
                    <tbody align="left">
                    <c:forEach items="${messageList}" var="message" varStatus="status">
                        <tr>
                            <td>${status.count }</td>
                            <td>${message.fromName}</td>
                            <td>${message.messageTitle}</td>
                            <td>${message.messageContent }</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty messageList}">
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
<script type="text/javascript" src="${basePath }js/select2.js"></script>
<script type="text/javascript">
    $("#messageType").on('change',function (e) {
        $('#messageForm').submit()
    })
    $("#teacherId").on('change',function (e) {
        $('#messageForm').submit()
    })
</script>
</body>
</html>