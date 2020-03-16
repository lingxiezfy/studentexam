package web.manager;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Clazz;
import entity.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ClazzService;
import service.StudentService;
import util.ParamUtil;

import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.manager
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到学生管理
 */
@Controller
@RequestMapping("/manager")
public class ManagerStudentController {
    @Autowired
    private StudentService studentService;
    @Autowired
    private ClazzService clazzService;

    /**
     * 跳转到学生管理页面
     * @param pageNum
     * @param gradeName
     * @param majorName
     * @param realname
     * @param model
     * @return String
     */
    @RequestMapping("/stuList")
    public String stuList(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String gradeName, String majorName, String realname, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Map> students =  studentService.selectStudentListBySelective(gradeName, majorName, realname);
        PageInfo<Map> pageInfo = new PageInfo<Map>(students);
        model.addAttribute("pageInfo",pageInfo);
        //返回参数
        model.addAttribute("gradeName",gradeName);
        model.addAttribute("majorName",majorName);
        model.addAttribute("realname",realname);
        ParamUtil.clear();
        ParamUtil.addParam("gradeName",gradeName); //返回分页
        ParamUtil.addParam("majorName",majorName);
        ParamUtil.addParam("realname",realname);
        return "manager/student_list";
    }

    /**
     * 删除学生
     * @param sid
     * @return String
     */
    @RequestMapping("/deleteStudent/{sid}")
    @ResponseBody
    public String deleteStudent(@PathVariable("sid") Integer sid){
        String result = studentService.deleteStudent(sid);
        return result;
    }

    /**
     * 跳转到学生添加页面
     * @return String
     */
    @RequestMapping("/toAddStudent")
    public String toAddStudent(){
        return "manager/student_add";
    }

    /**
     * 添加学生
     * @param student
     * @return String
     */
    @RequestMapping("/saveStudent")
    @ResponseBody
    public String saveStudent(Student student){
        String result = studentService.insertStudent(student);
        return result;
    }

    /**
     * 跳转到学生编辑页面
     * @param sid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditStudent/{sid}")
    public String toEditStudent(@PathVariable("sid") Integer sid,Model model){
        Student student = studentService.selectById(sid);
        if(student != null){
            Clazz clazz = clazzService.selectById(student.getFkClazz());
            model.addAttribute("clazz",clazz);
        }
        model.addAttribute("student",student);
        return "manager/student_edit";
    }

    /**
     * 更新学生信息
     * @param student
     * @return String
     */
    @RequestMapping("/updateStudent")
    @ResponseBody
    public String updateStudent(Student student){
        String result = studentService.updateStudent(student);
        return result;
    }
}
