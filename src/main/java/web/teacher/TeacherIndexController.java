package web.teacher;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.teacher
 * @Author: ztx
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到主页界面
 */
@Controller
@RequestMapping("/teacher")
public class TeacherIndexController {
    /**
     * 跳转到主页
     * @return
     */
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "teacher/teacher_index";
    }
}
