<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>教师功能</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-th-list"></i>教师功能</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
            <li class="breadcrumb-item">教师</li>
            <li class="breadcrumb-item active"><a href="#">教师功能</a></li>
        </ul>
    </div>
    <div class="row">
    <div class="col-md-5">
        <div class="tile">
            <h4 class="tile-title"><a href="examPaper">试卷管理</a> </h4>
            <ul>
                <li>根据年级查询年级信息</li>
                <li>添加年级信息</li>
                <li>删除年级信息</li>
            </ul>
        </div>
    </div>
    <div class="col-md-5">
        <div class="tile">
            <h4 class="tile-title"><a href="single">单选题</a></h4>
            <ul>
                <li>添加单选题</li>
                <li>修改单选题</li>
                <li>删除单选题</li>
            </ul>
        </div>
    </div>
</div>
    <div class="row">
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="multi">多选题</a> </h4>
                <ul>
                    <li>添加多选题</li>
                    <li>修改多选题</li>
                    <li>删除多选题</li>
                </ul>
            </div>
        </div>
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="judge">判断题</a></h4>
                <ul>
                    <li>添加判断题</li>
                    <li>修改判断题</li>
                    <li>删除判断题</li>
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