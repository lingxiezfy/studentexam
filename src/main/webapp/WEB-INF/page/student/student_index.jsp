<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>学生功能</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-th-list"></i>学生功能</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
            <li class="breadcrumb-item">学生</li>
            <li class="breadcrumb-item active"><a href="#">学生功能</a></li>
        </ul>
    </div>
    <div class="row">
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="examList">参加考试</a> </h4>
                <ul>
                    <li>查看考试信息</li>
                    <li>参加考试</li>
                </ul>
            </div>
        </div>
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="examHistory">考试记录</a></h4>
                <ul>
                    <li>查看考试成绩</li>
                    <li>查看试卷信息</li>
                </ul>
            </div>
        </div>
    </div>
</main>
<script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
<script type="text/javascript" src="${basePath }js/main.js"></script>
<script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>
<script type="text/javascript">


</script>
</body>
</html>