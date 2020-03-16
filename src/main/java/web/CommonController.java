package web;

import entity.Clazz;
import entity.Grade;
import entity.Major;
import entity.QuestionType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ClazzService;
import service.GradeService;
import service.MajorService;
import service.QuestionTypeService;

import java.util.List;
/**
 * @BelongsProject: exam
 * @BelongsPackage: web
 * @Author:
 * @CreateTime: 2019-09-24 22:06
 * @Description:跳转到所有信息界面
 */
@Controller
@RequestMapping("/common")
public class CommonController {
    @Autowired
    private GradeService gradeService;
    @Autowired
    private MajorService majorService;
    @Autowired
    private ClazzService clazzService;
    @Autowired
    private QuestionTypeService typeService;

    /**
     * 获取所有年级列表
     * @param name
     * @return List<Grade>
     */
    @RequestMapping("/getGradeAll")
    @ResponseBody
    public List<Grade> getGradeAll(String name){
        List<Grade> list = gradeService.getGradeBySelective(name);
        return list;
    }

    /**
     * 获取所有专业列表
     * @param name
     * @return List<Major>
     */
    @RequestMapping("/getMajorAll")
    @ResponseBody
    public List<Major> getMajorAll(String name){
        List<Major> list = majorService.getMajorListByName(name);
        return list;
    }

    /**
     * 获取所有班级列表
     * @param gradeId
     * @param majorId
     * @return List<Clazz>
     */
    @RequestMapping("/getClazzAll")
    @ResponseBody
    public List<Clazz> getClazzAll(Integer gradeId,Integer majorId){
        List<Clazz> list = clazzService.getClazzAllByGradeIdAndMajorId(gradeId, majorId);
        return list;
    }

    /**
     * 获取题型列表
     * @return List<QuestionType>
     */
    @RequestMapping("/getQuestionTypeAll")
    @ResponseBody
    public List<QuestionType> getQuestionTypeAll(){
        List<QuestionType> list = typeService.getQuestionTypeAll();
        return list;
    }
}
