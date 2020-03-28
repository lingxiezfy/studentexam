package web.manager;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Clazz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ClazzService;
import util.ParamUtil;

import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到班级管理
 */
@Controller
@RequestMapping("/adminManager")
public class ManagerClazzController {
    @Autowired
    private ClazzService clazzService;

    /**
     * 将班级信息显示
     * @param pageNum
     * @param gradeName
     * @param majorName
     * @param model
     * @return String
     */
    @RequestMapping("/clazz")
    public String clazz(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String gradeName, String majorName, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Map> clazzs = clazzService.getClazzAllByGradeAndMajor(gradeName, majorName);
        //将查询到的列表封装到pageInfo中
        PageInfo<Map> pageInfo = new PageInfo<Map>(clazzs);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("gradeName",gradeName);
        model.addAttribute("majorName",majorName);
        ParamUtil.clear();
        ParamUtil.addParam("gradeName",gradeName);
        ParamUtil.addParam("majorName",majorName);
        return "manager/clazz_list";
    }

    /**
     * 跳转到班级添加页面
     * @return String
     */
    @RequestMapping("/toAddClazz")
    public String toAddClazz(){
        return "manager/clazz_add";
    }

    /**
     * 保存班级信息
     * @param clazz
     * @return String
     */
    @RequestMapping("/saveClazz")
    @ResponseBody
    public String saveClazz(Clazz clazz){
        String result = clazzService.saveClazz(clazz);
        return result;
    }

    /**
     * 删除班级
     * @param cid
     * @return String
     */
    @RequestMapping("/delClazz/{cid}")
    @ResponseBody
    public String delClazz(@PathVariable("cid") Integer cid){
        String result = clazzService.deleteClazz(cid);
        return result;
    }
}
