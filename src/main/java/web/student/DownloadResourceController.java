package web.student;

import entity.Clazz;
import entity.Student;
import entity.Teacher;
import entity.TeacherClazz;
import mapper.ClazzMapper;
import mapper.TeacherClazzMapper;
import mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import web.teacher.ClassResourceController;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/3/28 15:54 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@RequestMapping("student")
@Controller
public class DownloadResourceController {

    @Autowired
    TeacherClazzMapper teacherClazzMapper;

    @Autowired
    ClazzMapper clazzMapper;

    @RequestMapping("toDownloadPage")
    public String toDownloadPage(HttpSession session, Model model){
        Student student = (Student)session.getAttribute("user");
        if(student.getFkClazz() != null && student.getFkClazz() > 0){
            Clazz clazz = clazzMapper.selectByPrimaryKey(student.getFkClazz());
            model.addAttribute("clazz", clazz.getDelFlag() == 0 ? clazz : null);
            List<Teacher> teacherList = teacherClazzMapper.selectTeacherByClazzId(student.getFkClazz());
            model.addAttribute("teacherList",teacherList);
        }
        return "student/class_resource";
    }


    @Autowired
    ClassResourceController classResource;

    @RequestMapping("/selectResource")
    @ResponseBody
    public Map<String,Object> resourceList(HttpSession session,Integer teacherId,String path){
        Student student = (Student)session.getAttribute("user");
        Map<String,Object> response = new HashMap<>();
        response.put("data",new ArrayList<>());
        response.put("code",1);
        response.put("count",0);
        if(teacherId == null || teacherId <= 0){
            response.put("msg","请选择教师进行资源浏览");
            return response;
        }
        TeacherClazz search = new TeacherClazz();
        search.setFkClazz(student.getFkClazz());
        search.setFkTeacher(teacherId);
        TeacherClazz teacherClazz = teacherClazzMapper.selectByFKTeacherAndFKClazz(search);
        if(teacherClazz == null){
            response.put("msg","选择的教师无效或者你没有浏览权限");
            return response;
        }
        return classResource.resourceList(session,teacherId,path);
    }




}
