package web.manager;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Grade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.GradeService;
import util.ParamUtil;

import java.util.List;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到年级管理
 */
@Controller
@RequestMapping("/adminManager")
public class ManagerGradeController {
    @Autowired
    private GradeService gradeService;

    /**
     * 跳转到年级管理页面
     * @param pageNum
     * @param name
     * @param model
     * @return String
     */
    @RequestMapping("/grade")
    public String grade(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum,String name, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Grade> grades = gradeService.getGradeBySelective(name);
        //将查询到的列表封装到pageInfo中
        PageInfo<Grade> pageInfo = new PageInfo<Grade>(grades);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("name",name);
        ParamUtil.clear(); //分页，保存查询的关键字
        ParamUtil.addParam("name",name);
        return "manager/grade_list";
    }

    /**
     * 删除年级数据
     * @param gid
     * @return String
     */
    @RequestMapping("/delGrade/{gid}")
    @ResponseBody
    public String delGrade(@PathVariable("gid") Integer gid){
        String result = gradeService.deleteGradeById(gid);
        return result;
    }

    /**
     * 跳转到年级添加页面
     * @return String
     */
    @RequestMapping("/toAddGrade")
    public String  toAddGrade(){
        return "manager/grade_add";
    }

    /**
     * 添加年级数据
     * @param grade
     * @return String
     */
    @RequestMapping("/saveGrade")
    @ResponseBody
    public String saveGrade(Grade grade){
        String result = gradeService.saveGrade(grade);
        return result;
    }
}
