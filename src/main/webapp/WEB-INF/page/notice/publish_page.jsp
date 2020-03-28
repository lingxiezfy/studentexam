<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/28
  Time: 20:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>发布公告</title>
    <link rel="stylesheet" href="${basePath}layui/css/layui.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        &nbsp;
    </div>
    <div class="layui-row">
        <div class="layui-form layui-form-pane"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
            <div class="layui-form-item">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="公告标题" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">公告</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入公告内容" name="content" lay-verify="required" class="layui-textarea"></textarea>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <button class="layui-btn" lay-submit lay-filter="*">立即提交</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${basePath}layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form','jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;

        form.on('submit(*)', function(data){
            console.log(data.field);//当前容器的全部表单字段，名值对形式：{name: value}
            // 提交成功后返回信息，关闭弹出层
            parent.layer.msg('操作成功',{
                icon:1,
                time: 1000
            });
            //当你在iframe页面关闭自身时
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    });
</script>
</html>
