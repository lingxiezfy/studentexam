package web.teacher;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Work;
import entity.WorkClazz;
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
import java.util.Date;
import java.util.List;
import java.util.Map;

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
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toSelectWorkClazz/{eid}")
    public String toSelectWorkClazz(@PathVariable("eid") Integer eid,Model model){
        
        List<Map> list = workClazzService.getWorkClazzAllByWorkId(eid);
        model.addAttribute("list",list);
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
        String result = workService.updateStatus(eid,endTime,2);
        return result;
    }

}
