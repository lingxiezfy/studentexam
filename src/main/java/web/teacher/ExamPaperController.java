package web.teacher;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.Exam;
import entity.ExamClazz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.*;
import util.ParamUtil;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @BelongsProject: exam
 * @BelongsPackage: web.teacher
 * @Author: ztx
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到试卷管理界面
 */
@Controller
@RequestMapping("/teacher")
public class ExamPaperController {
    @Autowired
    private ExamService examService;
    @Autowired
    private QuestionSingleService singleService;
    @Autowired
    private QuestionMultiService multiService;
    @Autowired
    private QuestionJudgeService judgeService;
    @Autowired
    private ExamClazzService clazzService;
    @Autowired
    private ExamQuestionsService questionsService;

    /**
     * 试卷列表
     * @param pageNum
     * @param title
     * @param model
     * @return String
     */
    @RequestMapping("/examPaper")
    public String examPaper(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Model model){
        PageHelper.startPage(pageNum,3); //分页，每页3条数据，pageNumber:页码
        List<Exam> exams = examService.getExamAllBySelective(title);
        PageInfo<Exam> pageInfo = new PageInfo<Exam>(exams);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("title",title);
        ParamUtil.addParam("title",title);
        return "teacher/exam_paper";
    }

    /**
     * 跳转到试卷添加页面
     * @return String
     */
    @RequestMapping("/toAddPaper")
    public String toAddPaper(){
        return "teacher/exam_add";
    }

    /**
     * 添加试卷
     * @param exam
     * @param session
     * @return String
     */
    @RequestMapping("/savePaper")
    @ResponseBody
    public String savePaper(Exam exam, HttpSession session){
        String result = examService.saveExam(exam,session);
        return result;
    }

    /**
     * 跳转到试卷题目列表
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/examQuestions/{eid}")
    public String examQuestions(@PathVariable("eid") Integer eid, Model model){
        //查询试卷基本信息
        Exam exam = examService.getExamId(eid);
        model.addAttribute("exam",exam);
        List<Map> questions = questionsService.getExamAllByExamId(eid);
        model.addAttribute("questions",questions);
        return "teacher/exam_questions";
    }

    /**
     * 跳转到题库页面
     * @param qtype
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toQuestionList")
    public String toQuestionList(Integer qtype,Integer eid,Model model){
        if(qtype != null){
            if(qtype == 1){
                List<Map> questions = singleService.getSingleAllBySelective(null,qtype);
                model.addAttribute("questions",questions);

            }else if(qtype == 2){
                List<Map> questions = multiService.getMultiAllBySelective(null,qtype);
                model.addAttribute("questions",questions);

            }else if(qtype == 3){
                List<Map> questions = judgeService.getjudgeAllBySelective(null,qtype);
                model.addAttribute("questions",questions);

            }
            model.addAttribute("qtype",qtype);
        }
        model.addAttribute("eid",eid);
        return "teacher/question_list";
    }

    /**
     * 跳转到试卷编辑页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditPaper/{eid}")
    public String toEditPaper(@PathVariable("eid") Integer eid,Model model){
        Exam exam = examService.getExamId(eid);
        model.addAttribute("exam",exam);
        model.addAttribute("eid",eid);
        return "teacher/exam_edit";
    }

    /**
     * 编辑试卷
     * @param exam
     * @param session
     * @return String
     */
    @RequestMapping("/updatePaper")
    @ResponseBody
    public String updatePaper(Exam exam,HttpSession session){
        String result = examService.updateExam(exam, session);
        return result;
    }

    /**
     * 删除试卷
     * @param eid
     * @return String
     */
    @RequestMapping("/deleteExam/{eid}")
    @ResponseBody
    public String deleteExam(@PathVariable("eid") Integer eid){
        String result = examService.deleteExam(eid);
        return result;
    }

    /**
     * 跳转到试卷使用班级列表页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toSelectClazz/{eid}")
    public String toSelectClazz(@PathVariable("eid") Integer eid,Model model){
        List<Map> list = clazzService.getExamClazzAllByExamId(eid);
        model.addAttribute("list",list);
        return "teacher/exam_clazz_list";
    }

    /**
     * 保存试卷和班级的关联关系
     * @param examClazz
     * @return String
     */
    @RequestMapping("/examClazzSelect")
    @ResponseBody
    public String examClazzSelect(ExamClazz examClazz){
        String result = clazzService.saveExamClazz(examClazz);
        return result;
    }

    /**
     * 删除试卷班级关联关系
     * @param eid
     * @return String
     */
    @RequestMapping("/delExamClazz/{eid}")
    @ResponseBody
    public String delExamClazz(@PathVariable("eid") Integer eid){
        String result = clazzService.deleteExamClazz(eid);
        return result;
    }

    /**
     * 添加试卷
     * @param ids
     * @param eid
     * @param qtype
     * @return Integer
     */
    @RequestMapping("/addQuestions")
    @ResponseBody
    public Integer addQuestions(String ids,Integer eid,Integer qtype){
        Integer num = questionsService.saveQuestions(ids, eid, qtype);
        return num;
    }

    /**
     * 删除试卷和题的关联关系
     * @param id
     * @param fkQuestion
     * @param fkQtype
     * @param fkExam
     * @return String
     */
    @RequestMapping("/deleteExamQuestions")
    @ResponseBody
    public String deleteExamQuestions(Integer id,Integer fkQuestion,Integer fkQtype,Integer fkExam){
        String result = questionsService.deleteExamQuestions(id, fkQuestion, fkQtype, fkExam);
        return result;
    }

    /**
     * 跳转到试卷运行设置页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/toExamRunning/{eid}")
    public String toExamRunning(@PathVariable("eid") Integer eid,Model model){
        model.addAttribute("eid",eid);
        return "teacher/exam_running";
    }

    /**
     * 设置开始运行
     * @param eid
     * @param endTime
     * @return String
     */
    @RequestMapping("/examRunning")
    @ResponseBody
    public String examRunning(Integer eid,@DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime){
        String result = examService.updateStatus(eid,endTime,3);
        return result;
    }

    /**
     * 设置停止运行
     * @param eid
     * @return String
     */
    @RequestMapping("/examStop/{eid}")
    @ResponseBody
    public String examStop(@PathVariable("eid") Integer eid){
        Date endTime = new Date();
        String result = examService.updateStatus(eid,endTime,2);
        return result;
    }

    /**
     * 编辑题目后，重新计算试卷总分
     * @param fkQuestion
     * @param qtype
     * @param examId
     * @param oldPoints
     * @return String
     */
    @RequestMapping("/updateExamPoints")
    @ResponseBody
    public String updateExamPoints(Integer fkQuestion,Integer qtype,Integer examId,Double oldPoints){
        String result = examService.updateExamPoints(fkQuestion, qtype, examId, oldPoints);
        return result;
    }
}
