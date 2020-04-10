/**

 @Name: 求解板块

 */

layui.define('fly', function (exports) {

    var $ = layui.jquery;
    var layer = layui.layer;
    var util = layui.util;
    var laytpl = layui.laytpl;
    var form = layui.form;
    var fly = layui.fly;

    var hostPath = getHost();

    function getHost() {
        var cur = window.document.location.href;
        var path = window.document.location.pathname;
        return cur.substring(0, cur.indexOf(path))
    }

    var gather = {}, dom = {
        jieda: $('#jieda')
        , content: $('#L_content')
        , jiedaCount: $('#jiedaCount')
    };

    //监听专栏选择
    form.on('select(column)', function (obj) {
        var value = obj.value
            , elemQuiz = $('#LAY_quiz')
            , tips = {
            tips: 1
            , maxWidth: 250
            , time: 10000
        };
        elemQuiz.addClass('layui-hide');
        if (value === '0') {
            layer.tips('下面的信息将便于您获得更好的答案', obj.othis, tips);
            elemQuiz.removeClass('layui-hide');
        } else if (value === '99') {
            layer.tips('系统会对【分享】类型的帖子予以飞吻奖励，但我们需要审核，通过后方可展示', obj.othis, tips);
        }
    });

    //帖子管理
    gather.jieAdmin = {
        //删贴子
        del: function (div) {
            layer.confirm('确认删除该求解么？', function (index) {
                layer.close(index);
                fly.json(hostPath + '/community/post/del/' + div.data('id'), {}, function (res) {
                    if (res.success) {
                        layer.alert(res.msg, {
                            icon: 1,
                            time: 10 * 1000,
                            end: function () {
                                location.href = hostPath + '/community/list';
                            }
                        });
                    } else {
                        layer.msg(res.msg);
                    }
                });
            });
        }

        //设置置顶、状态
        , set: function (div) {
            var othis = $(this);
            fly.json(hostPath + '/community/post/set/' + div.data('id'), {
                rank: othis.attr('rank')
                , field: othis.attr('field')
            }, function (res) {
                if (res.success) {
                    location.reload();
                }
            });
        }
    };

    $('body').on('click', '.jie-admin', function () {
        var othis = $(this), type = othis.attr('type');
        gather.jieAdmin[type] && gather.jieAdmin[type].call(this, othis.parent());
    });

    //解答操作
    gather.jiedaActive = {
        reply: function (li) { //回复
            var val = dom.content.val();
            var aite = '@' + li.find('.fly-detail-user cite').text().replace(/\s/g, '');
            dom.content.focus();
            if (val.indexOf(aite) !== -1) return;
            dom.content.val(aite + ' ' + val);
        }
        , edit: function (li) { //编辑
            fly.json(hostPath+'/community/reply/info/'+li.data('id'), {}, function (res) {
                var data = res.data;
                layer.prompt({
                    formType: 2
                    , value: data.content
                    , maxlength: 100000
                    , title: '编辑回帖'
                    , area: ['728px', '300px']
                    , success: function (layero) {
                        fly.layEditor({
                            elem: layero.find('textarea')
                        });
                    }
                }, function (value, index) {
                    fly.json(hostPath+'/community/saveReply', {
                        id: li.data('id')
                        , content: value
                    }, function (res) {
                        layer.close(index);
                        li.find('.detail-body').html(fly.content(value));
                    });
                });
            });
        }
        , del: function (li) { //删除
            layer.confirm('确认删除该回复么？', function (index) {
                layer.close(index);
                fly.json(hostPath + '/community/reply/del/'+li.data('id'), {}, function (res) {
                    if (res.success) {
                        location.reload();
                    } else {
                        layer.msg(res.msg);
                    }
                });
            });
        }
    };

    $('.jieda-reply span').on('click', function () {
        var othis = $(this), type = othis.attr('type');
        gather.jiedaActive[type].call(this, othis.parents('li'));
    });


    //定位分页
    if (/\/page\//.test(location.href) && !location.hash) {
        var replyTop = $('#flyReply').offset().top - 80;
        $('html,body').scrollTop(replyTop);
    }

    exports('jie', null);
});