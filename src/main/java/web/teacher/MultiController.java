package web.teacher;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import entity.QuestionMulti;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.QuestionMultiService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.teacher
 * @Author: ztx
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到多选题界面
 */
@Controller
@RequestMapping("/teacher")
public class MultiController {
    @Autowired
    private QuestionMultiService multiService;

    /**
     * 跳转到多选题列表
     * @param pageNum
     * @param title
     * @param qtype
     * @param model
     * @return String
     */
    @RequestMapping("/multi")
    public String multi(@RequestParam(value = "pageNum",defaultValue = "1",required = true)Integer pageNum, String title, Integer qtype, Model model){
        PageHelper.startPage(pageNum,3);
        List<Map> multis = multiService.getMultiAllBySelective(title, qtype);
        PageInfo<Map> pageInfo = new PageInfo<Map>(multis);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("tltle",title);
        model.addAttribute("qtype",qtype);
        return "teacher/question_multi_list";
    }

    /**
     * 跳转到多选题添加页面
     * @return String
     */
    @RequestMapping("/toAddMulti")
    public String toAddMulti(){
        return "teacher/question_multi_add";
    }

    /**
     * 保存多选题
     * @param questionMulti
     * @param session
     * @return String
     */
    @RequestMapping("/saveMulti")
    @ResponseBody
    public String saveMulti(QuestionMulti questionMulti, HttpSession session){
        String result = multiService.saveMulti(questionMulti, session);
        return result;
    }

    /**
     * 跳转到编辑多选题
     * @param mid
     * @param model
     * @return String
     */
    @RequestMapping("/toEditMulti/{mid}")
    public String toEditMulti(@PathVariable("mid")Integer mid, Model model){
        QuestionMulti multi = multiService.getMultiById(mid);
        model.addAttribute("multi",multi);
        model.addAttribute("mid",mid);
        return "teacher/question_multi_edit";
    }

    /**
     * 更新多选题
     * @param questionMulti
     * @param session
     * @return String
     */
    @RequestMapping("/updateMulti")
    @ResponseBody
    public String updateMulti(QuestionMulti questionMulti,HttpSession session){
        String result = multiService.updateMulti(questionMulti, session);
        return result;
    }

    /**
     * 删除多选题
     * @param mid
     * @return String
     */
    @RequestMapping("/delMulti/{mid}")
    @ResponseBody
    public String delMulti(@PathVariable("mid") Integer mid){
        String result = multiService.deleteMulti(mid);
        return result;
    }
}
