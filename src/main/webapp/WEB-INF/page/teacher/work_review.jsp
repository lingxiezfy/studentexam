<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/25
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>作业批改</title>
    <link rel="stylesheet" href="${basePath}layui/css/layui.css">
    <link rel="stylesheet" href="${basePath}layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${basePath}layui_ext/dtree/font/dtreefont.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <div class="layui-col-md2">
            <div class="layui-card">
                <div class="layui-card-header">
                    <strong>班级</strong>
                    &nbsp;
                    <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" onclick="toStatistics(${work.id})">去统计</button>
                </div>
                <div class="layui-card-body">
                    <div id="classTreeDiv" style="height: 350px;overflow: auto;" >
                        <ul id="classTree" class="dtree" data-id="0"></ul>
                    </div>
                </div>
            </div>

        </div>
        <div class="layui-col-md10">
            <div class="layui-row">
                <div class="layui-card">
                    <div class="layui-card-header">习题：<strong>${work.title}</strong></div>
                    <div class="layui-card-body" style="min-height: 60px;max-height: 120px;overflow-x: auto;overflow-y: scroll">
                        ${work.content}
                    </div>
                </div>
            </div>
            <div class="layui-row">
                &nbsp;
            </div>
            <div class="layui-row">
                <iframe name="view-iframe" id="view-iframe"></iframe>
            </div>
            <div class="layui-row">
                &nbsp;
            </div>
            <div class="layui-row">
                <div class="layui-form" lay-filter="pointForm" id="pointForm" action=""> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">打分</label>
                            <div class="layui-input-inline">
                                <input type="text" name="point" lay-verify="required|number" autocomplete="off" class="layui-input" value="0">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <button class="layui-btn" lay-submit lay-filter="pointFormSubmit">确定</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>

<script type="text/javascript" src="${basePath}layui/layui.js"></script>
<script type="text/javascript">
    layui.extend({
        dtree: '${basePath}layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['dtree','layer','jquery','form'], function(){
        var dtree = layui.dtree, layer = layui.layer, $ = layui.jquery;
        var form = layui.form;

        $("#view-iframe").css("width","100%");
        $("#view-iframe").css("height","50vh");
        // 初始化树
        var classTree = dtree.render({
            elem: "#classTree",
            url: "${basePath}teacher/workClazzTree/${work.id}", // 使用url加载（可与data加载同时存在）
            scroll:"#classTreeDiv",
            width:"100%",
            accordion: true,  // 开启手风琴accordion: true  // 开启手风琴
            line: true,
            ficon:["2","-1"],
            icon:"-1",
            none: "未分配班级!"
        });

        form.on('submit(pointFormSubmit)', function(data){
            if($("#pointForm").attr("action")){
                $.ajax({
                    url:$("#pointForm").attr("action"),
                    data:"point="+data.field.point,
                    success:function () {
                        layer.msg("批阅成功");
                    },
                    error:function () {
                        layer.msg('批阅失败!', {icon: 5});
                    }
                });
            }
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        // 绑定节点点击
        dtree.on("node('classTree')" ,function(obj){
            console.log(obj);
            if(!obj.param.leaf){
                var $div = obj.dom;
                classTree.clickSpread($div);  //调用内置函数展开节点
            } else {
                if(obj.param.level === "2"){
                    $.ajax({
                        url:"${basePath}teacher/viewWorkSubmit?workId=${work.id}&studentId="+obj.param.nodeId,
                        type:"GET",
                        success:function (res) {
                            if(res.submit && res.submit.id){
                                $("#pointForm").attr("action","${basePath}teacher/point/"+res.submit.id)
                            }else {
                                $("#pointForm").attr("action","");
                            }
                            if(res.submit && res.submit.fileUrl){
                                var file = "${basePath}upload"+res.submit.fileUrl;
                                $("#view-iframe").attr("src","http://localhost:8012/onlinePreview?url="+encodeURIComponent(file));
                            }else {
                                layer.msg("该学生未提交作业！");
                                $("#view-iframe").attr("src","");
                            }
                            if(res.correct){
                                form.val("pointForm", {
                                    "point": res.correct.point
                                });
                            }else {
                                form.val("pointForm", {
                                    "point": 0
                                });
                            }
                        },
                        error:function () {
                            layer.msg("获取失败！");
                            $("#pointForm").attr("action","");
                            $("#view-iframe").attr("src","");
                            form.val("pointForm", {
                                "point": 0
                            });
                        }
                    });
                }else {
                    layer.msg("该班级没有学生");
                }
            }
        });
    });

    function toStatistics(workId){
        layer.open({
            type: 2,
            title:"统计",
            area: ['700px', '450px'],
            maxmin: true,
            content: '${basePath}teacher/toStatistics/'+workId
        });
    }
</script>
</html>
