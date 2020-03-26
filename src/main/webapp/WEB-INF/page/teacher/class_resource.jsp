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
</head>
<body style="padding-top: 50px;padding-left: 250px;">

    <button type="button" class="layui-hide" id="uploadResourceBtn"></button>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>课堂资源</legend>
    </fieldset>
    <div class="layui-fluid">
        <div id="fileManager" lay-filter="manageResource"></div>
    </div>

</body>

<script type="text/javascript" src="${basePath}layui/layui.js"></script>
<script type="text/javascript">

    layui.extend({
        fileManager: '${basePath}layui_ext/fileManager/fileManager'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['fileManager','layer','jquery','upload'], function() {
        var fileManager = layui.fileManager, layer = layui.layer, $ = layui.jquery;
        var upload = layui.upload;
        var upIns = upload.render({
            elem: '#uploadResourceBtn' //绑定元素
            , url: '${basePath}teacher/uploadResource' //上传接口
            , field: 'file[]'
        });
        fileManager.render({
            elem: '#fileManager'
            , method: 'post'
            , id: 'fmTest'
            , btn_upload: true
            , btn_create: true
            , icon_url: '${basePath}layui_ext/fileManager/ico/'
            , url: '${basePath}teacher/resourceList'
            , thumb: {'nopic': '${basePath}layui_ext/fileManager/ico/null-100x100.jpg', 'width': 100, 'height': 100}
            , parseData: function (res) {
                /*
                data:[{
                    thumb:文件地址用于显示
                    ,type:文件类型  directory文件夹,png|gif|png|image图片,其它任意
                    ,path:文件夹路径用于打开本文件夹
                }]
                */
                let _res = {};
                _res.code = 0;
                _res.data = res.data;
                _res.count = res.count;
                return _res;
            }
            , done: function (res, curr, count) {
                console.log(res,curr,count)
            }
        });
        //监听图片上传事件
        fileManager.on('uploadfile(manageResource)', function(obj){
            //obj.obj 当前对象
            //obj.path 路径
            //更改上传组件参数
            upIns.config.data={'path':obj.path};
            upIns.config.done = function(res){
                fileManager.reload('fmTest');
            };
            var e = document.createEvent("MouseEvents");
            e.initEvent("click", true, true);
            document.getElementById("uploadResourceBtn").dispatchEvent(e)
        });
        //监听新建文件夹事件
        fileManager.on('new_dir(manageResource)', function(obj){
            //obj.obj 当前对象
            //obj.folder 文件夹名称
            //obj.path 路径
            $.post('${basePath}teacher/createFolder',{'folder':obj.folder,'path':obj.path},function(e){
                layer.msg(e.msg);
                if(e.code == 1){
                    fileManager.reload('fmTest');
                }
            })
        });
    });
</script>
</html>
