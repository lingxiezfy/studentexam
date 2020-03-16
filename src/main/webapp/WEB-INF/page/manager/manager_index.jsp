<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>管理员功能</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-th-list"></i>管理员功能</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
            <li class="breadcrumb-item">管理员</li>
            <li class="breadcrumb-item active"><a href="#">管理员功能</a></li>
        </ul>
    </div>
    <div class="row">
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="grade">年级管理</a> </h4>
                    <ul>
                        <li>根据年级查询年级信息</li>
                        <li>添加年级信息</li>
                        <li>删除年级信息</li>
                    </ul>
            </div>
        </div>
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="major">专业管理</a></h4>
                <ul>
                    <li>根据年级查询专业信息</li>
                    <li>添加专业信息</li>
                    <li>删除专业信息</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="clazz">班级管理</a> </h4>
                <ul>
                    <li>根据年级或专业查询班级信息</li>
                    <li>添加班级信息</li>
                    <li>删除班级信息</li>
                </ul>
            </div>
        </div>
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="stuList">学生管理</a> </h4>
                <ul>
                    <li>根据年级、专业或姓名查询学生信息</li>
                    <li>添加学生信息</li>
                    <li>修改学生信息</li>
                    <li>删除学生信息</li>
                </ul>
            </div>
        </div>
        <div class="col-md-5">
            <div class="tile">
                <h4 class="tile-title"><a href="teaList">教师管理</a> </h4>
                <ul>
                    <li>根据姓名查询教师信息</li>
                    <li>添加教师信息</li>
                    <li>显示教师管理班级的信息</li>
                    <li>修改教师信息</li>
                    <li>删除教师信息</li>
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