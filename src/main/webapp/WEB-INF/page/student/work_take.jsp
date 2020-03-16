<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查看作业信息</title>

    <link rel="BOOKMARK" href="${basePath }images/icon.png">
    <link rel="stylesheet" type="text/css" href="${basePath }css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/head.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/list_main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/bootstrap-admin-theme.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/work_take.css"/>
    <style>
        .col-center-block {
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        .hasBeenAnswer {
            background: #5d9cec;
            color: #fff;
        }

    </style>

    <script>
        var workId = "${eid}";
    </script>

</head>
<body>
<div class="container">
    <div class="row myCenter">
        <div class="col-md-12">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">作业详情：</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <div class="col-lg-4 form-group">
                                <label class="col-lg-4 control-label">作业名:</label>
                                <label class="col-lg-8 control-label"><span>${work.title}</span></label>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="col-lg-6 control-label">提交截止时间:</label>
                                <label class="col-lg-6 control-label"><span>${work.timeLimit }分钟</span></label>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="col-lg-6 control-label">学生姓名:</label>
                                <label class="col-lg-6 control-label"><span>${user.realname }</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default bootstrap-admin-no-table-panel">
						<div class="panel-heading">
							<div class="text-muted bootstrap-admin-box-title">作业内容：</div>
						</div>
						<div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
							<div class="col-lg-12 form-group">
								<span>${work.content}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
        </div>




    </div>
</div>

<script type="text/javascript" src="${basePath }js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/base.js"></script>
<script type="text/javascript" src="${basePath }js/tips.js"></script>
<script type="text/javascript" src="${basePath }js/work_take.js"></script>


</body>
</html>