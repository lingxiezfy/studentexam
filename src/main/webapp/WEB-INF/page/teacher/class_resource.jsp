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
        fileManager: '${basePath}layui_ext/fileManager/fileManager_src'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
        ,mouseRightMenu:'${basePath}layui_ext/mouseRightMenu/mouseRightMenu'
    }).use(['fileManager','layer','jquery','upload','mouseRightMenu'], function() {
        var fileManager = layui.fileManager,
            layer = layui.layer,
            $ = layui.jquery,
            mouseRightMenu = layui.mouseRightMenu ;
        var upload = layui.upload;
        var upIns = upload.render({
            elem: '#uploadResourceBtn' //绑定元素
            ,accept: 'file'
            , url: '${basePath}teacher/uploadResource' //上传接口
            , field: 'file[]'
        });
        fileManager.render({
            elem: '#fileManager'
            , method: 'post'
            , id: 'fmTest'
            , btn_upload: true
            , btn_create: true
            , file_base: '${basePath}'
            , icon_url: 'layui_ext/fileManager/ico/'
            , url: '${basePath}teacher/resourceList'
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
                _res.code = 0;
                _res.data = res.data;
                _res.count = res.count;
                _res.name = res.name;
                return _res;
            }
        });
        //监听上传事件
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
                if(e.success){
                    fileManager.reload('fmTest');
                }
            })
        });

        //监听选择事件
        // fileManager.on('fileClick(manageResource)', function (obj) {
        //     //obj.obj 当前对象
        //     //obj.data 当前文件数据
        //     var data = obj.data;
        //     layer.alert(JSON.stringify(data), {
        //         title: '当前数据：'
        //     });
        // });

        //监听右键事件
        fileManager.on('rightClick(manageResource)', function (obj) {
            //obj.obj 当前对象
            //obj.data 当前文件数据
            var data = obj.data;
            var ele = obj.obj;
            data['parent'] = obj.parent;
            var menu_data=[
                {'data':data,'type':1,'title':'取消'},
            ];
            if (ele.data('type') !== 'DIR') {
                menu_data.push({'data':data,'type':2,'title':'下载'})
            }
            menu_data.push({'data':data,'type':3,'title':'删除'});
            mouseRightMenu.open(menu_data,{area:"80px"},function(menu){
                // layer.alert(menu.type+"  "+JSON.stringify(menu.data),{title:menu.title});
                switch (menu.type) {
                    case 1:
                        break;
                    case 2:
                        layer.open({
                            type: 2,
                            title: '下载',
                            shadeClose: true,
                            shade: 0.8,
                            area: ['530px', '80%'],
                            content: menu.data.thumb //iframe的url
                        });
                        break;
                    case 3: // 删除
                        layer.confirm('确认要删除吗，不可恢复？', {
                            icon:3,
                            btn: ['确认','取消'] //按钮
                        }, function(){
                            $.ajax({
                                url:'${basePath}teacher/deleteResource',
                                method: 'post',
                                data:{
                                    name:menu.data.name,
                                    parent:menu.data.parent
                                },
                                success:function (res) {
                                    if(res){
                                        layer.msg('删除成功', {icon: 1});
                                        fileManager.reload('fmTest');
                                    }else {
                                        layer.msg('删除失败', {icon: 2});
                                    }
                                },
                                error:function () {
                                    layer.msg('删除失败,连接服务器失败', {icon: 2});
                                }
                            });
                        });
                        break;
                    default:break
                }

            })
        });
    });
</script>
</html>
