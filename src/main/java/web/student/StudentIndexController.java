package web.student;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web.student
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到学生主页
 */
@Controller
@RequestMapping("/student")
public class StudentIndexController {
    /**
     * String
     * @return 跳转到主页
     */
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "student/student_index";
    }
}
