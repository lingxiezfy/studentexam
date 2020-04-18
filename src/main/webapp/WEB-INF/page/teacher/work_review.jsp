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
                    <div class="layui-card-header">
                        习题：<strong>${work.title}</strong>
                    </div>
                    <div class="layui-card-body" style="min-height: 60px;max-height: 120px;overflow-x: auto;overflow-y: scroll">
                        ${work.content}
                    </div>
                </div>
            </div>
            <hr class="layui-bg-orange">
            <div class="layui-row">
                <c:choose>
                    <c:when test="${work.exFlag == 1}">
                        <div class="layui-col-md6">
                            <div class="layui-card">
                                <div class="layui-card-header">
                                    <strong>初始化SQL(为了不影响判断结果，请保证初始化Sql能够被重复执行)</strong>
                                </div>
                                <div class="layui-card-body" style="min-height: 150px;max-height: 200px;overflow-x: auto;overflow-y: scroll">
                                        ${work.exInitSql}
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-card">
                                <div class="layui-card-header">
                                    <strong>学生提交</strong>
                                    <button class="layui-btn layui-btn-normal layui-btn-xs" data-submit-id="0" id="runSqlBtn">
                                        运行查看结果
                                    </button>
                                </div>
                                <div class="layui-card-body" style="min-height: 150px;max-height: 200px;overflow-x: auto;overflow-y: scroll">
                                    <iframe name="view-iframe" id="view-iframe"></iframe>
                                </div>
                            </div>
                        </div>
                        <hr class="layui-bg-orange">
                        <div class="layui-col-md12">
                            <div class="layui-tab layui-tab-card" lay-filter="runResult">
                                <ul class="layui-tab-title">
                                    <li class="layui-this">运行结果</li>
                                </ul>
                                <div class="layui-tab-content" style="min-height: 100px;">
                                    <div class="layui-tab-item layui-show" id="runMessage">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <iframe name="view-iframe" id="view-iframe"></iframe>
                    </c:otherwise>
                </c:choose>
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
    var $;
    layui.extend({
        dtree: '${basePath}layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['dtree','layer','jquery','form','element'], function(){
        var dtree = layui.dtree, layer = layui.layer,element = layui.element;;
        var form = layui.form;
        $ = layui.jquery;

        $("#view-iframe").css("width","99%");
        <c:if test="${work.exFlag != 1}">
            $("#view-iframe").css("height","60vh");
        </c:if>

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
            }else {
                layer.msg("该学生暂未交作业！");
            }
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        // 绑定节点点击
        dtree.on("node('classTree')" ,function(obj){
            if(!obj.param.leaf){
                var $div = obj.dom;
                classTree.clickSpread($div);  //调用内置函数展开节点
            } else {
                if(obj.param.level === "2"){
                    $.ajax({
                        url:"${basePath}teacher/viewWorkSubmit?workId=${work.id}&studentId="+obj.param.nodeId,
                        type:"GET",
                        beforeSend:function(){
                            clearRunResult();
                        },
                        success:function (res) {
                            if(res.submit && res.submit.id){
                                $("#pointForm").attr("action","${basePath}teacher/point/"+res.submit.id)
                            }else {
                                $("#pointForm").attr("action","");
                            }
                            if(res.submit && res.submit.fileUrl){
                                var file = "${basePath}upload"+res.submit.fileUrl;
                                $("#runSqlBtn").data('submit-id',res.submit.id);
                                $("#view-iframe").attr("src","http://localhost:8012/onlinePreview?url="+encodeURIComponent(file));

                                $("#runSqlBtn").trigger("click");
                            }else {
                                layer.msg("该学生未提交作业！");
                                $("#view-iframe").attr("src","");
                                $("#runSqlBtn").data('submit-id',0);
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
                            $("#runSqlBtn").data('submit-id',0);
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
        var running = false;
        var tabs = [];
        $("#runSqlBtn").on('click',function () {
            if(!running){
                runWorkSql(this);
            }else {
                layer.msg("别着急，还在运行中。。。！");
            }
        });

        function clearRunResult() {
            $("#runMessage").html('<p>点击运行查看结果</p>');
            $.each(tabs,function (index,tabId) {
                element.tabDelete('runResult', ''+tabId);
            })
        }

        function runWorkSql(ele) {
            var submitId = parseInt($(ele).data("submit-id"));
            if(submitId <= 0){
                layer.msg("该学生未提交作业！");
            }else {
                $.ajax({
                    url:"${basePath}teacher/runWorkSql?workId=${work.id}&submitId="+submitId,
                    type:"GET",
                    beforeSend:function(){
                        running = true;
                        clearRunResult();
                    },
                    success:function (res) {
                        if(res.success){
                            $("#runMessage").html('<p style="color: green">'+res.msg+'</p>');
                            if(res.resultList.length <= 0){
                                $("#runMessage").html('<p style="color: red">未获取到执行语句，请检查SQL文件是否有效！！！</p>');
                            }else {
                                $.each(res.resultList,function (index,result) {
                                    var statement = '<blockquote class="layui-elem-quote layui-quote-nm">'+result.statement+'</blockquote>';
                                    var time = '<blockquote class="layui-elem-quote layui-quote-nm">耗时'+result.time+'ms</blockquote>';
                                    var effectRows = result.effectRows?('<blockquote class="layui-elem-quote layui-quote-nm">影响'+result.effectRows+'行</blockquote>'):'';
                                    var rowsTable;
                                    if(!result.effectRows){
                                        var header= '<tr>';
                                        header += '<th>结果集</th>';
                                        var body = '';
                                        var hasHead = false;
                                        $.each(result.rows,function (rowId,obj) {
                                            if(!hasHead){
                                                $.each(obj, function(key) {
                                                    header += '<th>'+key+'</th>';
                                                });
                                                hasHead = true;
                                            }
                                            body+='<tr>';
                                            body+='<td>'+(rowId+1)+'</td>';
                                            $.each(obj, function(key) {
                                                body+='<td>'+obj[key]+'</td>';
                                            });
                                            body+='</tr>';
                                        });
                                        header+='</tr>';
                                        if(!body){
                                            body+='<tr><td>未查询到结果</td></tr>';
                                        }
                                        rowsTable=
                                            '<table class="layui-table" lay-size="sm"><thead>'+header+'</thead><tbody>'+body+'</tbody></table>';
                                    }else {
                                        rowsTable = '';
                                    }
                                    var tabId = index+1;
                                    element.tabAdd('runResult', {
                                        title: '语句'+tabId
                                        ,content: statement+time+effectRows+rowsTable //支持传入html
                                        ,id: ''+tabId
                                    });
                                    tabs.push(tabId);
                                });
                            }
                        }else {
                            $("#runMessage").html('<p style="color: red">'+res.msg+'</p>');
                            if(res.exception){
                                $("#runMessage").append('<p>'+res.exception+'</p>');
                            }
                        }
                    },
                    error:function () {
                        $("#runMessage").html("执行失败，服务连接失败！");
                    },
                    complete:function () {
                        running = false;
                    }
                });
            }
        }
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
