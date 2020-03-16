package web.student;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ExamService;
import service.QuestionJudgeService;
import service.QuestionMultiService;
import service.QuestionSingleService;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @BelongsProject: exam
 * @BelongsPackage: web.student
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到参加考试界面
 */
@Controller
@RequestMapping("/student")
public class StudentExamController {
    @Autowired
    private ExamService examService;
    @Autowired
    private QuestionSingleService singleService;
    @Autowired
    private QuestionMultiService multiService;
    @Autowired
    private QuestionJudgeService judgeService;

    /**
     * 学生考试列表
     * @param session
     * @param model
     * @return String
     */
    @RequestMapping("/examList")
    public String examList(HttpSession session, Model model){
        Student student = (Student)session.getAttribute("user");
        List<Map> exams = examService.getExamsByStudent(student.getId());
        model.addAttribute("exams",exams);
        return "student/exam_list";
    }

    /**
     * 进入考试页面
     * @param eid
     * @param model
     * @return String
     */
    @RequestMapping("/examing/{eid}")
    public String examing(@PathVariable("eid") Integer eid, Model model){
        //查询试卷信息
        Exam exam = examService.getExamId(eid);
        //查询单选
        List<QuestionSingle> singles = singleService.getSingleAllByExamId(eid);
        //查询多选
        List<QuestionMulti> multis = multiService.getMultiAllByExamId(eid);
        //查询判断
        List<QuestionJudge> judges = judgeService.getJudgeAllByExamId(eid);
        model.addAttribute("exam",exam);
        model.addAttribute("singles",singles);
        model.addAttribute("multis",multis);
        model.addAttribute("judges",judges);
        return "student/exam_take";
    }

    /**
     * 提交试卷
     * @param result
     * @param session
     * @return Map<String,Object>
     * @throws IOException
     */
    @RequestMapping("/examSubmit")
    @ResponseBody
    public Map<String,Object> examSubmit(String result,HttpSession session) throws IOException {
        //获取考试学生信息
        Student student = (Student)session.getAttribute("user");
        //创建答案容器
        ExamAnswer answerVO = new ExamAnswer();
        //解析Json字符串
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.readTree(result);
        //获取试卷ID
        Integer examId = Integer.parseInt(jsonNode.findValue("examId").asText());
        answerVO.setExamId(examId);
        //解析单选题
        JsonNode singles = jsonNode.get("singles");
        for (JsonNode single : singles){
            //获取答题信息：存入map集合中
            String id = single.findValue("id").asText();
            String answer = single.findValue("answer").asText();
            answerVO.putSingle(Integer.parseInt(id),answer); //在单选题map中存放答案
        }

        //多选
        JsonNode multis = jsonNode.get("multis");
        for (JsonNode multi : multis){
            //获取答题信息：存入map集合中
            String id = multi.findValue("id").asText();
            String answer = multi.findValue("answer").asText();
            answerVO.putMulti(Integer.parseInt(id),answer);
        }

        //判断
        JsonNode judges = jsonNode.get("judges");
        for (JsonNode judge : judges){
            //获取答题信息：存入map集合中
            String id = judge.findValue("id").asText();
            String answer = judge.findValue("answer").asText();
            answerVO.putJudge(Integer.parseInt(id),answer);
        }
        //返回分数
        Map map = examService.marking(answerVO,student.getId());
        return map;
    }

}
