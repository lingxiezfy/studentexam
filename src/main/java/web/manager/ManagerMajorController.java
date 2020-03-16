package web.manager;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.MajorService;
import util.ParamUtil;


import java.util.List;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到专业管理
 */
@Controller
@RequestMapping("/manager")
public class ManagerMajorController {
    @Autowired
    private MajorService majorService;

    /**
     * 跳转到专业管理页面
     * @param pageNum
     * @param name
     * @param model
     * @return String
     */
    @RequestMapping("/major")
    public String major(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum,String name, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Major> majors = majorService.getMajorListByName(name);
        //将查询到的列表封装到pageInfo中
        PageInfo<Major> pageInfo = new PageInfo<Major>(majors);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("name",name);
        ParamUtil.clear();
        ParamUtil.addParam("name",name);
        return "manager/major_list";
    }

    /**
     * 跳转到专业添加页面
     * @return String
     */
    @RequestMapping("/toAddMajor")
    public String toAddMajor(){
        return "manager/major_add";
    }

    /**
     * 删除专业
     * @param mid
     * @return String
     */
    @RequestMapping("/delMajor/{mid}")
    @ResponseBody
    public String delMajor(@PathVariable("mid") Integer mid){
        String result = majorService.delMajor(mid);
        return result;
    }

    /**
     * 添加专业
     * @param major
     * @return String
     */
    @RequestMapping("/saveMajor")
    @ResponseBody
    public String saveMajor(Major major){
        String result = majorService.addMajor(major);
        return result;
    }
}
