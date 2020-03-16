package web.teacher;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.QuestionSingle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.QuestionSingleService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.teacher
 * @Author: ztx
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到单选题界面
 */
@Controller
@RequestMapping("/teacher")
public class SingleController {
    @Autowired
    private QuestionSingleService singleService;

    /**
     * 跳转到单选题列表
     * @param pageNum
     * @param title
     * @param qtype
     * @param model
     * @return String
     */
    @RequestMapping("/single")
    public String single(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Integer qtype, Model model){
        PageHelper.startPage(pageNum,3);
        List<Map> singles = singleService.getSingleAllBySelective(title, qtype);
        PageInfo<Map> pageInfo = new PageInfo<>(singles);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("title",title);
        model.addAttribute("qtype",qtype);
        return "teacher/question_single_list";
    }

    /**
     * 跳转到单选题添加页面
     * @return String
     */
    @RequestMapping("/toAddSingle")
    public String toAddSingle(){
        return "teacher/question_single_add";
    }

    /**
     * 保存单选题
     * @param single
     * @param session
     * @return String
     */
    @RequestMapping("/saveSingle")
    @ResponseBody
    public String saveSingle(QuestionSingle single, HttpSession session){
        String result = singleService.saveSingle(single,session);
        return  result;
    }

    /**
     * 跳转到编辑单选题
     * @param sid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditSingle/{sid}")
    public String toEditSingle(@PathVariable("sid")Integer sid,Model model){
        QuestionSingle single = singleService.getSingleById(sid);
        model.addAttribute("single",single);
        return "teacher/question_single_edit";
    }

    /**
     * 更新单选题
     * @param single
     * @param session
     * @return String
     */
    @RequestMapping("/updateSingle")
    @ResponseBody
    public String updateSingle(QuestionSingle single,HttpSession session){
        String result = singleService.updateSingle(single,session);
        return result;
    }

    /**
     * 删除单选题
     * @param sid
     * @return String
     */
    @RequestMapping("/delSingle/{sid}")
    @ResponseBody
    public String delSingle(@PathVariable("sid") Integer sid){
        String result = singleService.deleteSingle(sid);
        return result;
    }
}
