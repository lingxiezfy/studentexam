var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var basePath = window.location.protocol+"//"+window.location.host+projectName+"/";
var qtypeSelect = function(id,servicePath){
	$.ajax({
		type:'post',
		url:servicePath+'common/getQuestionTypeAll',
		dataType:'json',
		success:function(data){
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].type+"</option>");
				}
			}
			
		}
		
	})
}

var qtypeSelectWithDefault = function(id,selected,servicePath){
	$.ajax({
		type:'post',
		url:servicePath+'common/getQuestionTypeAll',
		dataType:'json',
		success:function(data){
			if(data!=null && data.length>0){
				for(var i=0;i<data.length;i++){
					if(data[i].id==selected){
						$("#"+id).append("<option value='"+data[i].id+"' selected>"+data[i].type+"</option>");
					}else{
						$("#"+id).append("<option value='"+data[i].id+"'>"+data[i].type+"</option>");
					}
				}
			}
			
		}
		
	})
}