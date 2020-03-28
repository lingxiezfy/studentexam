<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/26
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %><html>
<head>
    <title>课堂资源</title>
    <link rel="stylesheet" href="${basePath}layui/css/layui.css">
    <link rel="stylesheet" href="${basePath}layui_ext/mouseRightMenu/mouseRightMenu.css">
</head>
<body style="padding-top: 50px;padding-left: 250px;">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>资料下载</legend>
        <div class="layui-form">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <select id="teacher" name="teacher" lay-filter="teacherSelect">
                        <option value="">=== 选择一位老师 ===</option>
                        <c:forEach items="${teacherList}" var="teacher">
                            <option value="${teacher.id}">${teacher.realname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
    </fieldset>
    <div class="layui-fluid">
        <div id="fileManager" lay-filter="manageResource"></div>
    </div>

</body>

<script type="text/javascript" src="${basePath}layui/layui.js"></script>
<script type="text/javascript">

    layui.extend({
        fileManager: '${basePath}layui_ext/fileManager/fileManager_src'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
        ,mouseRightMenu:'${basePath}layui_ext/mouseRightMenu/mouseRightMenu'
    }).use(['fileManager','layer','jquery','form','mouseRightMenu'], function() {
        var fileManager = layui.fileManager,
            layer = layui.layer,
            $ = layui.jquery,
            form = layui.form,
            mouseRightMenu = layui.mouseRightMenu ;

        fileManager.render({
            elem: '#fileManager'
            , method: 'post'
            , id: 'fmTest'
            ,btn_upload:false
            ,btn_create:false
            , file_base: '${basePath}'
            , icon_url: 'layui_ext/fileManager/ico/'
            , url: '${basePath}student/selectResource'
            , thumb: {'nopic': 'layui_ext/fileManager/ico/null-100x100.jpg', 'width': 100, 'height': 68}
            , parseData: function (res) {
                /*
                data:[{
                    name:文件名
                    ,thumb:文件地址用于显示
                    ,type:文件类型  directory文件夹,png|gif|png|image图片,其它任意
                    ,path:文件夹路径用于打开本文件夹
                }]
                */
                if(res.data){
                    for(var i = 0;i<res.data.length;i++){
                        res.data[i].thumb = '${basePath}'+res.data[i].thumb;
                    }
                }
                let _res = {};
                _res.code = res.code;
                _res.data = res.data;
                _res.count = res.count;
                _res.name = res.name;
                _res.msg = res.msg;
                return _res;
            }
        });

        form.on('select(teacherSelect)', function (data) {
            fileManager.reload("fmTest",{
                where: { //设定异步数据接口的额外参数，任意设
                    teacherId: data.value
                }
            });
        });

        //监听右键事件
        fileManager.on('rightClick(manageResource)', function (obj) {
            //obj.obj 当前对象
            //obj.data 当前文件数据

            var data = obj.data;
            var ele = obj.obj;
            if (ele.data('type') === 'DIR') {
                return;
            }
            var menu_data=[
                {'data':data,'type':1,'title':'取消'},
                {'data':data,'type':2,'title':'下载'}
            ];
            mouseRightMenu.open(menu_data,{area:"80px"},function(menu){
                switch (menu.type) {
                    case 1:
                        break;
                    case 2:
                        layer.open({
                            type: 2,
                            title: '下载预览',
                            shadeClose: true,
                            shade: 0.8,
                            area: ['530px', '80%'],
                            content: menu.data.thumb //iframe的url
                        });
                        break;
                    default:break
                }

            })
        });
    });
</script>
</html>
