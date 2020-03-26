<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/26
  Time: 6:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>统计作业提交</title>
    <link rel="stylesheet" href="${basePath}layui/css/layui.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        &nbsp;
    </div>
    <div class="layui-row">
    &nbsp;
    </div>
    <div class="layui-row">
        <table id="workSubmitInfo" lay-filter="workSubmitInfo"></table>
    </div>
</div>
</body>

<script type="text/html" id="toolbarDemo">
    <div class="layui-form">
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <select id="clazz" name="clazz" lay-verify="required" lay-filter="clazzSelect">
                    <option value="">==筛选班级==</option>
                    <c:forEach items="${clazzList}" var="clazz">
                        <option value="${clazz.id}">${clazz.cno}班</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-input-block">
                共 <strong class="workTotal">0</strong>份
                ，已提交 <strong class="workHasSubmit" style="color: red;">0</strong>份
                ，还剩<strong class="workWaitSubmit" style="color: red;">0</strong> 份待交
            </div>
        </div>
    </div>
</script>

<script type="text/javascript" src="${basePath}layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['table', 'form','jquery'], function () {
        var table = layui.table;
        var form = layui.form;
        var $ = layui.jquery;
        var listTable = table.render({
            elem: '#workSubmitInfo'
            , height: "300"
            , url: '${basePath}teacher/statistics' //数据接口
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['print', 'exports']
            , method: 'post'
            , where: {
                workId:${work.id},
                classId: 0
            }
            , cols: [[ //表头
                {field: 'studentId', title: '学生Id', fixed: 'left'}
                , {field: 'realname', title: '姓名', fixed: 'left'}
                , {field: 'className', title: '班级'}
                , {field: 'workTitle', title: '练习'}
                , {field: 'submitTime', title: '提交时间', sort: true}
                , {field: 'correctTime', title: '批阅时间'}
                , {field: 'workPoint', title: '得分', sort: true}
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据
                $(".workTotal").html(res.count);
                $(".workHasSubmit").html(res.hasSubmit);
                $(".workWaitSubmit").html(res.waitSubmit);
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }

        });

        form.on('select(clazzSelect)', function (data) {
            console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象
            listTable.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    workId:${work.id},
                    classId: data.value
                }
            });
        });
    });
</script>
</html>
