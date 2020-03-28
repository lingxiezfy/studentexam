package interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * @BelongsProject: exam
 * @BelongsPackage: interceptor
 * @Author:
 * @CreateTime: 2019-09-24 22:35
 * @Description:用于过滤，只有当通过登录页面登录之后才能使用本程序
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 获取登录用户信息和角色
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return boolean
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获取请求URI
        String uri = httpServletRequest.getRequestURI();
        //从session中获取登录用户信息和角色id
        HttpSession session = httpServletRequest.getSession();
        Object user = session.getAttribute("user");
        Integer roleId = (Integer)session.getAttribute("role");
        if(uri.contains("/toLogin") || uri.contains("/doLogin") || uri.contains("/logOut")){
            return true;
        }
        if(user != null){
            //登录:学生
            if(uri.startsWith("/student")){
                if(roleId != 1){
                    httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toLogin");
                    return false;
                }
            }
            //登录:教师
            if(uri.startsWith("/teacher")){
                if(roleId != 2){
                    httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toLogin");
                    return false;
                }
            }
            //登录:管理员
            if(uri.startsWith("/adminManager")){
                if(roleId != 3){
                    httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toLogin");
                    return false;
                }
            }
        }else {
            //未登录
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toLogin");
            return false;
        }
        return true;
    }

    /**
     *
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @throws Exception
     */
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
    }

    /**
     *
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @throws Exception
     */
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
