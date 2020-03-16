package web.student;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.*;
import util.ParamUtil;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.student
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到学生考试记录
 */
@Controller
@RequestMapping("/student")
public class StudentHistoryController {
    @Autowired
    private ExamService examService;
    @Autowired
    private ExamResultService resultService;
    @Autowired
    private ExamResultQuestionService questionService;
    @Autowired
    private QuestionSingleService singleService;
    @Autowired
    private QuestionMultiService multiService;
    @Autowired
    private QuestionJudgeService judgeService;

    /**
     * 跳转到考试记录页面
     * @param pageNum
     * @param title
     * @param model
     * @param session
     * @return String
     */
    @RequestMapping("/examHistory")
    public String examHistory(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Model model, HttpSession session){
        Student student = (Student)session.getAttribute("user");
        PageHelper.startPage(pageNum,1);
        List<Map> results = resultService.getExamHistoryBySelective(title,student.getId());
        PageInfo<Map> pageInfo = new PageInfo<Map>(results);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("title",title);
        ParamUtil.addParam("title",title);
        return "student/exam_history_list";
    }

    /**
     * 跳转到试卷记录详情页面
     * @param examResultId
     * @param examId
     * @param model
     * @return String
     */
    @RequestMapping("/toHistory")
    public String toHistory(Integer examResultId, Integer examId, Model model){
        //查询试卷信息
        Exam exam = examService.getExamId(examId);
        //查询单选
        List<QuestionSingle> singles = singleService.getSingleAllByExamId(examId);
        //查询多选
        List<QuestionMulti> multis = multiService.getMultiAllByExamId(examId);
        //查询判断
        List<QuestionJudge> judges = judgeService.getJudgeAllByExamId(examId);
        //查询单选题考试结果及正确答案
        List<ExamResultQuestion> answers = questionService.getStudentAnswers(examResultId);
        model.addAttribute("exam",exam);
        model.addAttribute("singles",singles);
        model.addAttribute("multis",multis);
        model.addAttribute("judges",judges);
        model.addAttribute("answers",answers);
        return "student/exam_history";
    }
}
