package web.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到主页
 */
@Controller
@RequestMapping("/manager")
public class ManagerIndexController {
    /**
     * 跳转到主页
     * @return String
     */
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "manager/manager_index";
    }
}
