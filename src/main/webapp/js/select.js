//获取项目根目录
var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var basePath = window.location.protocol+"//"+window.location.host+projectName+"/";
var gradeSelect = function(id,servicePath){
	$.ajax({
		type:'post',
		url:servicePath+'common/getGradeAll',
		dataType:'json',
		success:function(data){
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
				}
			}
			
		}
	})
}



var majorSelect = function(id,servicePath){
	$.ajax({
		type:'post',
		url:servicePath+'common/getMajorAll',
		dataType:'json',
		success:function(data){
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
				}
			}
			
		}
		
	})
}

var qtypeSelect = function(id){
	alert("123");
	/*$.ajax({
		type:'post',
		url:basePath+'common/getQuestionTypeAll',
		dataType:'json',
		success:function(data){
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].type+"</option>");
				}
			}
			
		}
		
	})*/
}

