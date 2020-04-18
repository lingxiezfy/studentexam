package web.teacher;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.*;
import ex.dao.IExDao;
import mapper.*;
import org.apache.commons.lang.StringUtils;
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
import service.ex.ExService;
import util.ParamUtil;

import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
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

    /**
     * 进入统计页面
     */
    @RequestMapping("/toStatistics/{workId}")
    public String toStatistics(@PathVariable("workId") Integer workId,Model model){
        List<Clazz> clazzList = workClazzMapper.selectClassListByWorkId(workId);
        model.addAttribute("clazzList",clazzList);
        Work work = workService.getWorkId(workId);
        model.addAttribute("work",work);
        return "teacher/work_statistics";
    }

    /**
     * 统计学生提交
     */
    @RequestMapping("/statistics")
    @ResponseBody
    public Map<String,Object> statistics(Integer workId, Integer classId){
        Map<String,Object> response = new HashMap<>();
        List<Map> list = workSubmitMapper.statisticsSubmit(workId,classId);
        response.put("data",list);
        response.put("code",0);
        response.put("count",list.size());
        response.put("workId",workId == null ? 0:workId);
        response.put("classId",classId == null ? 0: classId);

        long waitSubmit = list.stream().filter(o->o.get("submitId").equals(0) || o.get("submitFile") == null).count();
        response.put("waitSubmit",waitSubmit);
        response.put("hasSubmit",list.size()-waitSubmit);
        response.put("message","请求成功");
        return response;
    }

    @Autowired
    WorkMapper workMapper;


    /**
     * 执行学生提交的Sql文件
     */
    @RequestMapping("/runWorkSql")
    @ResponseBody
    public Map<String,Object> runWorkSql(HttpSession session,Integer workId,Integer submitId){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        Work work = workMapper.selectByPrimaryKey(workId);
        if(work == null || work.getExFlag() != 1){
            response.put("msg","练习不存在或者不支持在线运行");
            return response;
        }
        WorkSubmit submit = workSubmitMapper.selectByPrimaryKey(submitId);
        if(submit == null || !submit.getFkWork().equals(workId) || StringUtils.isEmpty(submit.getFileUrl())){
            response.put("msg","未找到学生的提交文件！");
            return response;
        }
        String filePath = session.getServletContext().getRealPath("") + "upload"+submit.getFileUrl();
        return runWorkSubmit(work.getExInitSql(),filePath);
    }

    @Autowired
    ExService exService;
    @Autowired
    IExDao exDao;

    //原子操作
    private synchronized Map<String,Object> runWorkSubmit(String initSql,String submitFile){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        // 执行初始化sql
        if(StringUtils.isNotBlank(initSql)){
            try{
                exDao.exc(initSql);
            }catch (Exception e){
                response.put("msg","初始化执行失败！");
                response.put("exception",e.getMessage());
                return response;
            }
        }
        // 执行提交文件
        try{
            List<Map> resultList = exService.runScript(new InputStreamReader(new FileInputStream(submitFile)));
            response.put("success",true);
            response.put("msg","执行完成");
            response.put("resultList",resultList);
        }catch (IOException ioe){
            response.put("msg","提交文件有误，请检查提交！");
        }catch (Exception e){
            response.put("msg","执行过程发送错误！终止执行！");
            response.put("exception",e.getMessage());
        }
        return response;
    }

}
