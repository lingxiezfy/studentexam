package web.teacher;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.*;
import mapper.StudentMapper;
import mapper.WorkClazzMapper;
import mapper.WorkCorrectingMapper;
import mapper.WorkSubmitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ClazzService;
import service.WorkClazzService;
import service.WorkService;
import util.ParamUtil;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.*;

/**
 * @author User
 * @Title: WorkPaperController
 * @ProjectName work
 * @Description: 跳转到作业管理界面
 * @date 2020/2/23 17:08
 */
@Controller
@RequestMapping("/teacher")
public class WorkPaperController {

    @Autowired
    private WorkService workService;

    @Autowired
    private WorkClazzService workClazzService;

    /**
     * 作业列表
     * @param pageNum
     * @param title
     * @param model
     * @return
     */
    @RequestMapping("/workPaper")
    public String workPaper(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Work> works = workService.getWorkAllBySelective(title);
        PageInfo<Work> pageInfo = new PageInfo<Work>(works);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("title",title);
        ParamUtil.addParam("title",title);
        return "teacher/work_paper";
    }

    /**
     * 跳转到作业添加页面
     * @return String
     */
    @RequestMapping("/toAddWorkPaper")
    public String toAddWorkPaper(){
        return "teacher/work_add";
    }

    /**
     * 添加作业
     * @param work
     * @param session
     * @return String
     */
    @RequestMapping("/saveWorkPaper")
    @ResponseBody
    public String saveWorkPaper(Work work, HttpSession session){
        String result = workService.saveWork(work,session);
        return result;
    }

    /**
     * 删除作业
     * @param eid
     * @return String
     */
    @RequestMapping("/deleteWork/{eid}")
    @ResponseBody
    public String deleteWork(@PathVariable("eid") Integer eid){
        String result = workService.deleteWork(eid);
        return result;
    }

    /**
     * 跳转到作业编辑页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditWorkPaper/{eid}")
    public String toEditWorkPaper(@PathVariable("eid") Integer eid,Model model){
        Work work = workService.getWorkId(eid);
        model.addAttribute("work",work);
        model.addAttribute("eid",eid);
        return "teacher/work_edit";
    }

    /**
     * 编辑作业
     * @param work
     * @param session
     * @return String
     */
    @RequestMapping("/updateWorkPaper")
    @ResponseBody
    public String updateWorkPaper(Work work,HttpSession session){
        String result = workService.updateWork(work, session);
        return result;
    }

    /**
     * 跳转到作业使用班级列表页面
     * @return String
     */
    @RequestMapping("/toSelectWorkClazz/{workId}")
    public String toSelectWorkClazz(@PathVariable("workId") Integer workId,Model model){
        Work work = workService.getWorkId(workId);
        List<Map> list = workClazzService.getWorkClazzAllByWorkId(workId);
        model.addAttribute("list",list);
        model.addAttribute("work",work);
        return "teacher/work_clazz_list";
    }

    /**
     * 保存作业和班级的关联关系
     * @param workClazz
     * @return String
     */
    @RequestMapping("/workClazzSelect")
    @ResponseBody
    public String workClazzSelect(WorkClazz workClazz){
        String result = workClazzService.saveWorkClazz(workClazz);
        return result;
    }

    /**
     * 删除作业班级关联关系
     * @param eid
     * @return String
     */
    @RequestMapping("/delWorkClazz/{eid}")
    @ResponseBody
    public String delWorkClazz(@PathVariable("eid") Integer eid){
        String result = workClazzService.deleteWorkClazz(eid);
        return result;
    }

    /**
     * 跳转到作业运行设置页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toWorkRunning/{eid}")
    public String toWorkRunning(@PathVariable("eid") Integer eid,Model model){
        model.addAttribute("eid",eid);
        return "teacher/work_running";
    }

    /**
     * 设置开始运行
     * @param eid
     * @param endTime
     * @return String
     */
    @RequestMapping("/workRunning")
    @ResponseBody
    public String workRunning(Integer eid,@DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime){
        String result = workService.updateStatus(eid,endTime,3);
        return result;
    }

    /**
     * 设置停止运行
     * @param eid
     * @return String
     */
    @RequestMapping("/workStop/{eid}")
    @ResponseBody
    public String workStop(@PathVariable("eid") Integer eid){
        Date endTime = new Date();
        String result = workService.updateStatus(eid,endTime,4);
        return result;
    }

    @Autowired
    WorkClazzMapper workClazzMapper;
    @Autowired
    StudentMapper studentMapper;
    /**
     * 进入批改
     */
    @RequestMapping("/toReview/{workId}")
    public String toReview(@PathVariable("workId") Integer workId,HttpSession session,Model model){
        //获取当前登录用户
        Work work = workService.getWorkId(workId);
        model.addAttribute("work",work);
        return "teacher/work_review";
    }

    /**
     * 获取需要提交作业的班级列表
     */
    @RequestMapping("/workClazzTree/{workId}")
    @ResponseBody
    public Map<String,Object> workClazzTree(@PathVariable("workId") Integer workId){
        List<Clazz> clazzList = workClazzMapper.selectClassListByWorkId(workId);
        Map<String,Object> statusMap = new HashMap<>(6);
        statusMap.put("code",200);
        statusMap.put("message","操作成功");
        List<Map<String,Object>> dataList = new ArrayList<>();
        clazzList.forEach(clazz -> {
            Map<String,Object> dataMap = new HashMap<>();
            dataMap.put("id",clazz.getId().toString());
            dataMap.put("title",clazz.getCno()+"班");
            dataMap.put("parentId","0");
            dataMap.put("leaf","false");
            List<Map<String,Object>> childList = new ArrayList<>();
            List<Student> studentList = studentMapper.selectByClazzId(clazz.getId());
            studentList.forEach(student -> {
                Map<String,Object> studentMap = new HashMap<>();
                studentMap.put("id",student.getId().toString());
                studentMap.put("title",student.getRealname());
                studentMap.put("parentId",clazz.getId().toString());
                childList.add(studentMap);
            });
            dataMap.put("children",childList);
            dataList.add(dataMap);
        });
        JSONObject json = new JSONObject();
        json.put("status",statusMap);
        json.put("data",dataList);
        return json;
    }

    @Autowired
    WorkSubmitMapper workSubmitMapper;
    @Autowired
    WorkCorrectingMapper correctingMapper;


    @RequestMapping("/viewWorkSubmit")
    @ResponseBody
    public Map<String,Object> viewWorkSubmit(Integer studentId,Integer workId){
        Map<String,Object> response = new HashMap<>();
        WorkSubmit submit = workSubmitMapper.selectByWorkIdAndStudentId(workId,studentId);
        response.put("submit",submit);
        response.put("correct",submit != null?correctingMapper.selectBySubmitId(submit.getId()):null);
        return response;
    }




    @RequestMapping("/point/{submitId}")
    @ResponseBody
    public Boolean point(@PathVariable("submitId") Integer submitId, BigDecimal point, HttpSession session){
        Teacher teacher = (Teacher)session.getAttribute("user");
        WorkCorrecting correcting = correctingMapper.selectBySubmitId(submitId);
        WorkCorrecting editCor = new WorkCorrecting();
        editCor.setPoint(point.doubleValue());
        editCor.setCorTime(new Date());
        if(correcting == null){
            editCor.setFkSubmit(submitId);
            editCor.setFkTeacher(teacher.getId());
            correctingMapper.insertSelective(editCor);
        }else {
            editCor.setId(correcting.getId());
            correctingMapper.updateByPrimaryKeySelective(editCor);
        }
        return true;
    }

    @RequestMapping("/statistics/{workId}")
    public String statistics(@PathVariable("workId") Integer workId){
        return "teacher/work_statistics";
    }

}
