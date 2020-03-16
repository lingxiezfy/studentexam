package web.manager;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Teacher;
import entity.TeacherClazz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.TeacherClazzService;
import service.TeacherService;
import util.ParamUtil;

import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到教师管理
 */
@Controller
@RequestMapping("/manager")
public class ManagerTeacherController {
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private TeacherClazzService clazzService;

    /**
     * 跳转到教师管理页面
     * @param pageNum
     * @param realname
     * @param model
     * @return String
     */
    @RequestMapping("/teaList")
    public String teaList(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String realname, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Teacher> teachers = teacherService.getTeacherAllBySelective(realname);
        PageInfo<Teacher> pageInfo = new PageInfo<>(teachers);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("realname",realname);
        ParamUtil.clear();
        ParamUtil.addParam("realname",realname);
        return "manager/teacher_list";
    }

    /**
     * 跳转到教师添加页面
     * @return String
     */
    @RequestMapping("/toAddTeacher")
    public String toAddTeacher(){
        return "manager/teacher_add";
    }

    /**
     * 添加教师
     * @param teacher
     * @return String
     */
    @RequestMapping("/saveTeacher")
    @ResponseBody
    public String saveTeacher(Teacher teacher){
        String result = teacherService.saveTeacher(teacher);
        return result;
    }

    /**
     * 删除教师
     * @param tid
     * @return String
     */
    @RequestMapping("/deleteTeacher/{tid}")
    @ResponseBody
    public String deleteTeacher(@PathVariable("tid") Integer tid){
        String result = teacherService.deleteTeacher(tid);
        return  result;
    }

    /**
     * 跳转到教师编辑页面
     * @param tid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditTeacher/{tid}")
    public String toEditTeacher(@PathVariable("tid") Integer tid, Model model){
        Teacher teacher = teacherService.getTeacherById(tid);
        model.addAttribute("teacher",teacher);
        return "manager/teacher_edit";
    }

    /**
     * 修改教师信息
     * @param teacher
     * @return String
     */
    @RequestMapping("/updateTeacher")
    @ResponseBody
    public String updateTeacher(Teacher teacher){
        String result = teacherService.updateTeacher(teacher);
        return result;
    }

    /**
     * 跳转到班级选择页面
     * @param tid
     * @param model
     * @return String
     */
    @RequestMapping("/toSelectClazz/{tid}")
    public String toSelectClazz(@PathVariable("tid")Integer tid,Model model){
        List<Map> list = clazzService.getTeacherClazzAllByTeacherId(tid);
        model.addAttribute("list",list);
        model.addAttribute("tid",tid);
        return "manager/teacher_clazz_list";
    }

    /**
     * 保存教师和班级的关联信息
     * @param tc
     * @return String
     */
    @RequestMapping("/teaClazzSelect")
    @ResponseBody
    public String teacherClazzSelect(TeacherClazz tc){
        String result = clazzService.saveTeacherClazzService(tc);
        return result;
    }

    /**
     * 删除教师和班级的关联信息
     * @param tid
     * @return String
     */
    @RequestMapping("/delTeacherClazz/{tid}")
    @ResponseBody
    public String delTeacherClazz(@PathVariable("tid") Integer tid){
        String result = clazzService.deleteTeacherClazz(tid);
        return result;
    }
}
