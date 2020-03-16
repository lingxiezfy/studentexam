package web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.PasswordService;

import javax.servlet.http.HttpSession;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到修改密码界面
 */
@Controller
public class PasswordController {
    @Autowired
    PasswordService passwordService;

    /**
     * 跳转到修改密码页面
     * @return String
     */
    @RequestMapping("/toEditPwd")
    public String toEditPwd(){
        return "password";
    }

    /**
     * 更新密码
     * @param oldPwd
     * @param newPwd
     * @param session
     * @return
     */
    @RequestMapping("/updatePwd")
    @ResponseBody
    public String updatePwd(String oldPwd, String newPwd, HttpSession session){
        String result = passwordService.updatePwd(oldPwd, newPwd, session);
        return result;
    }
}
