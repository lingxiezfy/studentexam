package web.teacher;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.QuestionJudge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.QuestionJudgeService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.teacher
 * @Author: ztx
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到判断题界面
 */
@Controller
@RequestMapping("/teacher")
public class JudgeController {
    @Autowired
    private QuestionJudgeService judgeService;

    /**
     * 跳转到判断题列表
     * @param pageNum
     * @param title
     * @param qtype
     * @param model
     * @return String
     */
    @RequestMapping("/judge")
    public String judge(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Integer qtype, Model model){
        PageHelper.startPage(pageNum,3);
        List<Map> judges = judgeService.getjudgeAllBySelective(title, qtype);
        PageInfo<Map> pageInfo = new PageInfo<Map>(judges);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("title",title);
        model.addAttribute("qtype",qtype);
        return "teacher/question_judge_list";
    }

    /**
     * 跳转到判断题添加页面
     * @return String
     */
    @RequestMapping("/toAddJudge")
    public String toAddJudge(){
        return "teacher/question_judge_add";
    }

    /**
     * 保存判断题
     * @param judge
     * @param session
     * @return String
     */
    @RequestMapping("saveJudge")
    @ResponseBody
    public String saveJudge(QuestionJudge judge, HttpSession session){
        String result = judgeService.saveJudge(judge,session);
        return result;
    }

    /**
     * 跳转到编辑判断题
     * @param jid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditJudge/{jid}")
    public String toEditJudge(@PathVariable("jid") Integer jid, Model model){
        QuestionJudge judge = judgeService.getJudgeById(jid);
        model.addAttribute("judge",judge);
        return "teacher/question_judge_edit";
    }

    /**
     * 更新判断题
     * @param judge
     * @param session
     * @return Strings
     */
    @RequestMapping("/updateJudge")
    @ResponseBody
    public String updateJudge(QuestionJudge judge,HttpSession session){
        String result = judgeService.updateJudge(judge, session);
        return result;
    }

    /**
     * 删除判断题
     * @param jid
     * @return String
     */
    @RequestMapping("/delJudge/{jid}")
    @ResponseBody
    public String delJudge(@PathVariable("jid") Integer jid){
        String result = judgeService.deleteJudge(jid);
        return result;
    }
}
