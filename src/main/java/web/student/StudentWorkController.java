package web.student;

import entity.Student;
import entity.Work;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.WorkService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author User
 * @Title: StudentWorkController
 * @ProjectName studentexam1.0
 * @Description: 跳转到提交作业界面
 * @date 2020/3/12 15:52
 */

@Controller
@RequestMapping("/student")
public class StudentWorkController {

    @Autowired
    private WorkService workService;

    /**
     * 学生提交作业列表
     * @param session
     * @param model
     * @return String
     */
    @RequestMapping("/workSubmit")
    public String examList(HttpSession session, Model model){
        Student student = (Student)session.getAttribute("user");
        List<Map> works = workService.getWorksByStudent(student.getId());
        model.addAttribute("works",works);
        return "student/work_list";
    }

    /**
     * 进入作业页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/working/{eid}")
    public String examing(@PathVariable("eid") Integer eid, Model model){
        //查询作业信息
        Work work = workService.getWorkId(eid);
        model.addAttribute("work",work);
        return "student/work_take";
    }

    /**
     * 跳转到文件上传页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toUploadFile/{eid}")
    public String toUploadFile(@PathVariable("eid") Integer eid,Model model){
//        List<Map> list = clazzService.getExamClazzAllByExamId(eid);
//        model.addAttribute("list",list);
        return "student/work_submit";
    }
}
