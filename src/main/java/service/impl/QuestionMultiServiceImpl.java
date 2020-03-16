package service.impl;

import entity.QuestionMulti;
import entity.Teacher;
import mapper.QuestionMultiMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.QuestionMultiService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
@Service
public class QuestionMultiServiceImpl implements QuestionMultiService {
    @Autowired
    private QuestionMultiMapper multiMapper;
    private final int SINGLE = 1;
    private final int MULTI = 2;
    private final int JUDGE = 3;
    private final byte ADD = 0;
    private final byte DEL = 1;
    /*
    * 保存多选题
    * */
    @Override
    public String saveMulti(QuestionMulti questionMulti, HttpSession session) {
        String result = "error";
        //题目类型
        questionMulti.setFkQtype(MULTI);
        //出题人
        Teacher teacher = (Teacher)session.getAttribute("user");
        questionMulti.setFkTeacher(teacher.getId());
        //删除标识
        questionMulti.setDelFlag(ADD);
        //出题是否重复
        QuestionMulti hasMulti = multiMapper.selectByTitle(questionMulti.getTitle());
        if(hasMulti != null){
            if(hasMulti.getDelFlag() == DEL){
                //存在已删除
                questionMulti.setId(hasMulti.getId());
                Integer rows = multiMapper.updateByPrimaryKey(questionMulti);
                if(rows == 1){
                    return "ok";
                }
            }else {
                result = "exist";
            }
        }else {
            Integer rows = multiMapper.insertSelective(questionMulti);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
    * 根据条件查询所有多选题
    * */
    @Override
    public List<Map> getMultiAllBySelective(String title, Integer qtype) {
        if(StringUtils.isNotBlank(title)){
            title = "%"+title+"%";
        }
        return multiMapper.selectAllBySelective(title, qtype);
    }
    /*
     *根据主键查询
     * */
    @Override
    public QuestionMulti getMultiById(Integer id) {
        return multiMapper.selectByPrimaryKey(id);
    }
    /*
     *更新多选题
     * */
    @Override
    public String updateMulti(QuestionMulti questionMulti, HttpSession session) {
        String result = "error";
        QuestionMulti hasMulti = multiMapper.selectByTitleWithoutSelf(questionMulti);
        if(hasMulti != null){
            result = "exist";
        }else {
            Teacher teacher = (Teacher) session.getAttribute("user");
            questionMulti.setFkTeacher(teacher.getId());
            Integer rows = multiMapper.updateByPrimaryKeySelective(questionMulti);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     *删除多选题
     * */
    @Override
    public String deleteMulti(Integer mid) {
        QuestionMulti questionMulti = new QuestionMulti();
        questionMulti.setId(mid);
        questionMulti.setDelFlag(DEL);
        Integer rows = multiMapper.updateByPrimaryKeySelective(questionMulti);
        if(rows == 1){
            return "ok";
        }else{
            return "error";
        }

    }
    /*
    * 通过试卷ID查询所有多选题
    * */
    @Override
    public List<QuestionMulti> getMultiAllByExamId(Integer examId) {
        return multiMapper.selectAllByExamId(examId);
    }
}
