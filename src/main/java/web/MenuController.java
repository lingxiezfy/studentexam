package web;

import entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import service.MenuService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到菜单界面
 */
@Controller
public class MenuController {
    @Autowired
    private MenuService menuService;

    /**
     * 显示主页的菜单信息
     * @param session
     * @param model
     * @return String
     */
    @RequestMapping("/index")
    public String toIndex(HttpSession session, Model model){
        Integer roleId = (Integer) session.getAttribute("role");
        List<Menu> menus = menuService.getMenuByRoleId(roleId);
        model.addAttribute("menus",menus);
        return "index";
    }
}
