<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>试卷管理</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="${basePath}css/font-awesome.min.css">
  	
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-dashboard"></i> ${exam.title }</h1>
          <p>总分：${exam.totalPoints}|&nbsp;考试时间：${exam.timeLimit }分钟&nbsp;|&nbsp;单选题：${exam.singlePoints}&nbsp;|&nbsp;多选题：${exam.multiPoints}&nbsp;|&nbsp;判断题：${exam.judgePoints}</p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item">教师</li>
          <li class="breadcrumb-item active"><a href="#">试卷题目</a></li>
        </ul>
      </div>
      <div class="row">
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
          	<div class="tile-body">
              <div class="row">
                <div class="form-group col-md-12 " >
                  <button class="btn btn-primary" type="button" onclick="add('${exam.id}')" style="float:right"><i class="fa fa-fw fa-lg fa-plus-circle"></i>题库</button>
                </div>
              </div>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th>序号</th>
                  <th>题目</th>
                  <th>类型</th>
                  <th>分值</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${questions }" var="qs" varStatus="status">
	                <tr id="tr${qs.id }">
	                  <td>${status.count }</td>
	                  <td>${qs.title}</td>
	                  <td>${qs.type }</td>
	                  <td>${qs.score }</td>
	                  <td>
	                  	<button class="btn btn-info" type="button" style="height:30px;line-height:10px;" onclick="edit('${qs.fkQuestion}','${qs.fkQtype}','${qs.fkExam}','${qs.score}')">编辑</button>
	                  	<button class="btn btn-danger" type="button" style="height:30px;line-height:10px;" onclick="del('${qs.id}','${qs.fkQuestion}','${qs.fkQtype}','${qs.fkExam}')">删除</button>
	                  </td>
	                </tr>
              	</c:forEach>
              	<c:if test="${empty questions }">
              		<tr align="center">
              			<td colspan="5">暂无记录</td>
              		</tr>
              	</c:if>
              </tbody>
            </table>

          </div>
        </div>
      </div>
    </main>
    <script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${basePath }js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${basePath }js/main.js"></script>
    <script type="text/javascript" src="${basePath }tools/layer/layer.js"></script>

    <script type="text/javascript">

    	function del(id,fkQuestion,fkQtype,fkExam){
    		layer.confirm('您确定要删除吗？',
    			{btn:['确定','取消']},//按钮
    			function(){//确定
    				$.ajax({
    					type:'post',
    					url:'${basePath}teacher/deleteExamQuestions/',
                        data:{"id":id,"fkQuestion":fkQuestion,"fkQtype":fkQtype,"fkExam":fkExam},
    					success:function(data){
    						if(data=='ok'){
                                layer.alert("删除成功！",function(){
                                    window.location.reload();
                                });
    						}else{
    							layer.alert("删除失败！");
    						}
    					}
    				})
    			},function(){})//取消
		}
    	//添加试题
    	function add(eid){
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'选择试题',
	    		area:['800px','500px'],
	    		content:'${basePath}teacher/toQuestionList?qtype=1&eid='+eid,
	    		btn:'确定',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.add();
	    		},
	    	    cancel:function (index,layero) {
	    		    //关闭窗口
                    layer.close(index);
                    //刷新页面
                    window.location.reload();
                }
	    	})
    	}
    	//修改试卷
    	function edit(id,type,examId,oldPoints){
    	    var url = "";
    	    var width = "";
    	    if(type == 1){
    	        //单选
                url = '${basePath}teacher/toEditSingle/'+id;
                width='550px';
            }else if(type == 2){
    	        //多选
                url = '${basePath}teacher/toEditMulti/'+id;
                width='550px';
            }else if(type == 3){
                //判断
    	        url = '${basePath}teacher/toEditJudge/'+id;
                width='350px';
            }
	    	layer.open({
	    		type:2,//弹出iframe层
	    		title:'编辑试题',
	    		area:['500px',width],
	    		content:url,
	    		btn:'修改',
	    		skin:'my-skin',
	    		yes:function(index,layero){
	    			//调用弹出层页面js
	    			var iframeWin = window[layero.find('iframe')[0]['name']];
	    			iframeWin.toSubmit();
                    updateExamPoints(id,type,examId,oldPoints);
	    		}
	    	
	    	})
    	}

        /* 更新试卷分数（修改题目后重新计算分数） */
        function updateExamPoints(fkQuestion,qtype,examId,oldPoints){
            $.ajax({
                type:'post',
                url:'${basePath}teacher/updateExamPoints',
                data:{"fkQuestion":fkQuestion,"qtype":qtype,"examId":examId,"oldPoints":oldPoints},
                success:function(data){
                    if(data=='ok'){
                        window.location.reload();
                    }else{
                        layer.alert("试卷总分更新失败！");
                    }
                }
            })
        }
    </script>
  </body>
</html>