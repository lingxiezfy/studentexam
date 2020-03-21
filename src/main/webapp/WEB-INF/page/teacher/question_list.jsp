<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<html>
<head>
    <title>题库</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${basePath }css/main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/layer-skin.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  	<style type="text/css">
  		.app-content{
  			margin-left:0px;
  			margin-top:0px;
  		}
  	</style>
  </head>
  <body class="app sidebar-mini rtl">
    <main class="app-content" >
      <div class="row" >
        <div class="clearfix"></div>
        <div class="col-md-12">
          <div class="tile">
           <div class="tile-body">
              <form id="qtypeForm" class="row" action="${basePath }teacher/toQuestionList" method="post">
                <input type="hidden" value="${eid }" name="eid">
                <div class="form-group col-md-3">
                  <select class="form-control" id="qtype" name="qtype">
                    <option value = "">--请选择类型--</option>
                  </select>
                </div>
                <div class="form-group col-md-3 align-self-end">
                  <button class="btn btn-primary" type="submit"><i class="fa fa-fw fa-lg fa-check-circle"></i>筛选</button>
                </div>
              </form>
            </div>
            <table class="table table-bordered">
              <thead>
                <tr align="center">
                  <th><input type="checkbox" id="checkAll" name="checkAll" onclick="checkAll('checkAll','checkOne')"></th>
                  <th>序号</th>
                  <th>题目</th>
                  <th>类型</th>
                  <th>分值</th>
                  <th>出题老师</th>
                </tr>
              </thead>
              <tbody align="center">
              	<c:forEach items="${questions }" var="qs" varStatus="status">
                <tr id="tr${qs.id }">
                  <td><input type="checkbox" id="checkOne${qs.id }" name="checkOne" value="${qs.id }" onclick="checkOne('checkAll',this)"></td>
                  <td>${status.count }</td>
                  <td>${qs.title}</td>
                  <td>${qs.qtype }</td>
                  <td>${qs.score}</td>
                  <td>${qs.teacherName }</td>
                </tr>
              	</c:forEach>
              	<c:if test="${empty questions }">
              		<tr align="center">
              			<td colspan="6">暂无记录</td>
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
    <script type="text/javascript" src="${basePath }js/select2.js"></script>
    <script type="text/javascript">
	    $(function(){
          qtypeSelectWithDefault("qtype",'${qtype}');
          $("#qtype").change(function () {
            if($(this).val()){
              $("#qtypeForm").submit();
            }
          });
		});

    	
    	//添加试题
    	function add(){
	    	var eid = '${eid}';
	    	var qtype = '${qtype}';
	    	var ids="";
	    	var checkOnes = document.getElementsByName("checkOne");
	    	for(var i=0;i<checkOnes.length;i++){
				//拿到每一个复选框，并将其状态置为选中
				if(checkOnes[i].checked){
					if(ids==""){
						ids=checkOnes[i].value;
					}else{
						ids=ids+","+checkOnes[i].value;
					}
				}
			}
	    	if(ids == ''){
	    	  parent.layer.alert(请选择试题);
            }else {
              $.ajax({
                type:"post",
                url:"${basePath}teacher/addQuestions",
                data:{"ids":ids,"eid":eid,"qtype":qtype},
                success:function(data){
                  if(data>0){
                    layer.alert("添加成功"+data+"道题",function(){
                      window.location.reload();
                    });
                  }else{
                    layer.alert("添加失败或所选题目已添加过");
                  }
                }
              })
            }

	    	
    	}
	    
	    var ids='';
	    /* 全选 */
	    function checkAll(checkAll,checkOne){
	    	/* 获取全选 */
	    	var checkAllEle = document.getElementById(checkAll);
	    	if(checkAllEle.checked){
	    		//如果全选选中了
	    		//获取所有记录前面的复选框元素
	    		var checkOnes = document.getElementsByName(checkOne);
	    		for(var i=0;i<checkOnes.length;i++){
					//拿到每一个复选框，并将其状态置为选中
					checkOnes[i].checked=true;
				}
	    	}else{
	    		//全选没有选中
	    		//获取所有记录前面的复选框元素
				var checkOnes = document.getElementsByName(checkOne);
				//对获取的所有复选框进行遍历
				for(var i=0;i<checkOnes.length;i++){
					//拿到每一个复选框，并将其状态置为未选中
					checkOnes[i].checked=false;
				}
	    	}
	    }
	    /* 子选中框 */
	    function checkOne(checkAll,checkOne){
	    	//判断当前复选框是否选中了，如果选中了，查看所有的复选框是否都选中了，如果都选中了，将顶部全选框也选中，否则顶部全选框不选中
	    	if(checkOne.checked){
	    		var checkOnes = document.getElementsByName("checkOne");
	    		var checks = 0;
	    		for(var i=0;i<checkOnes.length;i++){
	    			if(checkOnes[i].checked){
	    				checks++;
	    			}
				}
	    		if(checks==checkOnes.length){
	    			document.getElementById(checkAll).checked=true;
	    		}
	    	}else{
	    		document.getElementById(checkAll).checked=false;
	    	}
	    }
    </script>
  </body>
</html>