package web;

import entity.Manager;
import entity.Student;
import entity.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ManagerService;
import service.StudentService;
import service.TeacherService;
import util.MD5Util;
import web.manager.UserCommon;

import javax.servlet.http.HttpSession;

/**
 * @BelongsProject: exam
 * @BelongsPackage: web
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到登录界面
 */
@Controller
public class LoginController {
    @Autowired
    StudentService studentService;
    @Autowired
    TeacherService teacherService;
    @Autowired
    ManagerService managerService;

    /**
     * 退出当前用户登录
     * @param session
     * @return String
     */
    @RequestMapping("logOut")
    public String logOut(HttpSession session){
        session.removeAttribute("user");
        session.removeAttribute("role");
        return  "redirect:toLogin";
    }

    /**
     * 跳转到登录页面
     * @return String
     */
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "login";
    }

    /**
     * 登录时的角色身份确认
     * @param username
     * @param password
     * @param role
     * @param session
     * @return String
     */
    @RequestMapping("/doLogin")
    @ResponseBody
    public String doLogin(String username, String password, Integer role, HttpSession session){
        String result = "error"; //返回内容：系统异常，请联系管理员
        if(role == 1){
            //此时的用户为学生
            Student student = studentService.getStudentByUsernameAndPassword(username, MD5Util.getMD5(password));
            if(student != null){
                //登录成功，用session记录用户
                session.setAttribute("user",student);
                session.setAttribute("role",role);
                session.setAttribute("userCommon", UserCommon.init(student));
                result = "ok";
            }else {
                result = "wrong";
            }
        }else if(role == 2){
            //此时用户为教师
            Teacher teacher = teacherService.getTeacherByUsernameAndPassword(username,MD5Util.getMD5(password));
            if(teacher != null){
                //登录成功，用session记录用户
                session.setAttribute("user",teacher);
                session.setAttribute("role",role);
                session.setAttribute("userCommon", UserCommon.init(teacher));
                result = "ok";
            }else{
                result = "wrong";
            }
        }else if(role == 3){
            //此时用户为管理员
            Manager manager = managerService.getManagerByUsernameAndPassword(username,MD5Util.getMD5(password));
            if(manager != null){
                //登录成功，用session记录用户
                session.setAttribute("user",manager);
                session.setAttribute("role",role);
                session.setAttribute("userCommon", UserCommon.init(manager));
                result = "ok";
            }else {
                result = "wrong";
            }
        }
        return result;
    }
}
