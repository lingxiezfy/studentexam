<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>判断题</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<main class="app-content">
    <div class="app-title">
        <div>
            <h1><i class="fa fa-th-list"></i>判断题</h1>
        </div>
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
            <li class="breadcrumb-item">教师</li>
            <li class="breadcrumb-item active"><a href="#">判断题</a></li>
        </ul>
    </div>
    <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
            <div class="tile">

                <div class="tile-body">
                    <form class="row" action="${basePath }teacher/judge" method="post">
                        <div class="form-group col-md-2">
                            <label class="control-label">题目：</label>
                            <div class="btn-group" data-toggle="buttons">
                                <input class="form-control" type="text" id="title" name="title" placeholder="请输入题目" value="${title }">
                            </div>
                        </div>
                        <div class="form-group col-md-2">
                            <label class="control-label">类型：</label>
                            <div class="btn-group" data-toggle="buttons">
                                <select class="form-control" id="qtype" name="qtype">
                                    <option value = "">--请选择类型--</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-6 align-self-end">
                            <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>查询</button>
                            <button class="btn btn-primary" type="button" onclick="add()"><i class="fa fa-fw fa-lg fa-plus-circle"></i>添加</button>
                        </div>
                    </form>
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr align="center">
                        <th>序号</th>
                        <th>题目</th>
                        <th>类型</th>
                        <th>分值</th>
                        <th>出题老师</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody align="center">
                    <c:forEach items="${pageInfo.list }" var="judge" varStatus="status">
                        <tr id="tr${judge.id }">
                            <td>${status.count }</td>
                            <td>${judge.title}</td>
                            <td>${judge.qtype }</td>
                            <td>${judge.score}</td>
                            <td>${judge.teacherName }</td>
                            <td>
                                <button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="edit('${judge.id}')">编辑</button>
                                <button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="del('${judge.id}')">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pageInfo.list }">
                        <tr align="center">
                            <td colspan="6">暂无记录</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <p:page action="teacher/judge"/>
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
    $(function(){
        qtypeSelect("qtype");
    })

    function del(jid){
        layer.confirm('您确定要删除吗？',
            {btn:['确定','取消']},//按钮
            function(){//确定
                $.ajax({
                    type:'post',
                    url:'${basePath}teacher/delJudge/'+jid,//restFull
                    success:function(data){
                        if(data=='ok'){
                            $("#tr"+jid).remove();
                            layer.alert("删除成功！");
                        }else{
                            layer.alert("删除失败！");
                        }
                    }
                })
            },function(){})//取消
    }

    //添加判断题
    function add(){
        layer.open({
            type:2,//弹出iframe层
            title:'添加判断题',
            area:['550px','400px'],
            content:'${basePath}teacher/toAddJudge',
            btn:'添加',
            skin:'my-skin',
            yes:function(index,layero){
                //调用弹出层页面js
                var iframeWin = window[layero.find('iframe')[0]['name']];
                iframeWin.toSubmit();
            }

        })
    }
    //弹出判断题修改页面
    function edit(sid){
        layer.open({
            type:2,//弹出iframe层
            title:'编辑单选题',
            area:['550px','450px'],
            content:'${basePath}teacher/toEditJudge/'+sid,
            btn:'修改',
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