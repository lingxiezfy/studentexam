package web.student;

import entity.Student;
import entity.Work;
import entity.WorkSubmit;
import mapper.WorkSubmitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import service.WorkService;
import util.UploadFileUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
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
    @Autowired
    private WorkSubmitMapper submitMapper;

    /**
     * 学生提交作业列表
     * @param session
     * @param model
     * @return String
     */
    @RequestMapping("/workSubmit")
    public String workList(HttpSession session, Model model){
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
    public String working(@PathVariable("eid") Integer eid,HttpSession session, Model model){
        //查询作业信息
        Work work = workService.getWorkId(eid);
        model.addAttribute("work",work);
        Student student = (Student)session.getAttribute("user");
        WorkSubmit submit = submitMapper.selectByWorkIdAndStudentId(work.getId(),student.getId());
        model.addAttribute("submit",submit);
        return "student/work_take";
    }

    /**
     * 作业上传
     */
    @RequestMapping("/workUpload")
    @ResponseBody
    public boolean workUpload(MultipartFile file,HttpSession session,Integer workId){
        //查询作业信息
        Work work = workService.getWorkId(workId);
        //获取提交作业的学生
        Student student = (Student)session.getAttribute("user");
        String tempPath = session.getServletContext().getRealPath("") + "upload";
        String realPath = "H:/ideaProjects/studentexam1.0/src/main/webapp/upload";
        String workPath = String.format("/work/student_%s",student.getId());
        String fileNameTemp = String.format("student_%s_work_%s",student.getId(),work.getId());
        String fileName = UploadFileUtils.upload(file,tempPath+workPath,realPath+workPath,fileNameTemp);
        if (fileName != null) {
            String filePath = workPath+"/"+fileName;
            WorkSubmit submit = submitMapper.selectByWorkIdAndStudentId(work.getId(),student.getId());
            if(submit == null){
                submit = new WorkSubmit();
                submit.setFileUrl(filePath);
                submit.setFkStudent(student.getId());
                submit.setFkWork(work.getId());
                submit.setWorkTitle(work.getTitle());
                submit.setSubTime(new Date());
                submitMapper.insertSelective(submit);
            }else {
                WorkSubmit updateSubmit = new WorkSubmit();
                updateSubmit.setId(submit.getId());
                updateSubmit.setFileUrl(filePath);
                updateSubmit.setSubTime(new Date());
                submitMapper.updateByPrimaryKeySelective(updateSubmit);
            }

            return true;
        }
        return false;
    }

}
