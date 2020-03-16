package tag;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.github.pagehelper.PageInfo;
import util.ParamUtil;



/**
 * 自定义分页标签
 * @author Administrator
 * 2019-09-07 19:47
 */
public class PageTag extends SimpleTagSupport {
	//必须有get set方法
	private String action;
	
	@Override
	public void doTag() throws JspException, IOException {
		//获取上下文
		PageContext pageContext = (PageContext)this.getJspContext();
		PageInfo pageInfo = (PageInfo)pageContext.getRequest().getAttribute("pageInfo");
		if(pageInfo != null){
			//获取绝对路径
			ServletRequest request = pageContext.getRequest();
			String path = request.getServletContext().getContextPath();
			String basePath = pageContext.getRequest().getScheme()		
					+"://"+pageContext.getRequest().getServerName()		
					+":"+pageContext.getRequest().getServerPort()		
					+path+"/";	//http://主机名：端口号/项目名										
			String pageBar = createPageBar(pageInfo,basePath);			
			pageContext.getOut().println(pageBar);
		}
	}
	
	/**
	 * 生成分页工具条
	 * @param pageInfo
	 * @param basePath
	 * @return
	 */
	public String createPageBar(PageInfo pageInfo,String basePath){
		StringBuffer sb = new StringBuffer();
		//当总页数大于1页的时候才需要分页工具条
		if(pageInfo.getPages()>1) {
			sb.append("<form method=\"post\" id=\"pageForm\" name=\"pageForm\" style=\"margin-bottom:0;height:35px\">");
			//将条件查询的参数设置的form的隐藏域中
			if(!ParamUtil.params.isEmpty()) {
				Iterator<Entry<String,Object>> ite = ParamUtil.params.entrySet().iterator();
				while(ite.hasNext()) {
					Entry<String,Object> et = (Entry<String,Object>)ite.next();
					String key = (String)et.getKey();
					Object value = (Object)et.getValue();
					sb.append("<input type='hidden' name='"+key+"' value='"+(value!=null?value:"")+"'>");
				}
			}
			
			sb.append("<div class=\"row\">");
			sb.append("<div class=\"col-sm-12 col-md-12\">");
			sb.append("<div class=\"pull-right\">");
			sb.append("<ul class=\"pagination\">");
			//首页和上一页按钮
			if(pageInfo.getPageNum()==pageInfo.getFirstPage()) {
				//当前页为1时，首页和上一页为disabled，无法点击
				sb.append("<li class=\"paginate_button page-item previous disabled\"><a href=\"#\" class=\"page-link\">首页</a></li>");
				sb.append("<li class=\"paginate_button page-item previous disabled\"><a href=\"#\" class=\"page-link\">上一页</a></li>");
			}else {
				//	否则可以使用
				sb.append("<li class=\"paginate_button page-item previous \"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+pageInfo.getFirstPage()+"';pageForm.submit();\" class=\"page-link\">首页</a></li>");
				sb.append("<li class=\"paginate_button page-item previous \"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+pageInfo.getPrePage()+"';pageForm.submit();\" class=\"page-link\">上一页</a></li>");
			}
			//中间的数字页码
			for(int i=1;i<=pageInfo.getPages();i++) {
				if(i==pageInfo.getPageNum()) {
					sb.append("<li class=\"paginate_button page-item active\"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+i+"';pageForm.submit();\" class=\"page-link\">"+i+"</a></li>");
				}else {
					sb.append("<li class=\"paginate_button page-item\"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+i+"';pageForm.submit();\" class=\"page-link\">"+i+"</a></li>");
				}
			}
			//结尾的下一页和最后一页按钮
			if(pageInfo.getPageNum()<pageInfo.getLastPage()) {
				sb.append("<li class=\"paginate_button page-item\"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+pageInfo.getNextPage()+"';pageForm.submit();\" class=\"page-link\">下一页</a></li>");
				sb.append("<li class=\"paginate_button page-item\"><a href=\"javascript:pageForm.action='"+basePath+action+"?pageNum="+pageInfo.getLastPage()+"';pageForm.submit();\" class=\"page-link\">最后一页</a></li>");
			}else {
				sb.append("<li class=\"paginate_button page-item disabled\"><a href=\"#\" class=\"page-link\">下一页</a></li>");
				sb.append("<li class=\"paginate_button page-item disabled\"><a href=\"#\" class=\"page-link\">最后一页</a></li>");
			}
			sb.append("</ul>");
			sb.append("</div>");
			sb.append("</div>");
			sb.append("</div>");
			sb.append("</form>");
		}
		return sb.toString();
	}
	
	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	
	
}
