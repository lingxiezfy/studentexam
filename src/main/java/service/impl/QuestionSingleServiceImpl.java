package service.impl;

import entity.QuestionSingle;
import entity.Teacher;
import mapper.QuestionSingleMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.QuestionSingleService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
@Service
public class QuestionSingleServiceImpl implements QuestionSingleService {
    @Autowired
    private QuestionSingleMapper singleMapper;

    private final int SINGLE = 1;
    private final int MULTI = 2;
    private final int JUDGE = 3;
    private final byte ADD = 0;
    private final byte DEL = 1;
    /*
    * 保存单选题
    * */
    @Override
    public String saveSingle(QuestionSingle single, HttpSession session) {
        String result = "error";
        //设置题目类型
        single.setFkQtype(SINGLE);
        //出题人
        Teacher teacher = (Teacher) session.getAttribute("user");
        single.setFkTeacher(teacher.getId());
        //删除标识
        single.setDelFlag(ADD);
        //判断该题是否存在
        QuestionSingle hasSingle = singleMapper.selectByTitle(single.getTitle());
        if(hasSingle != null){
            //存在但是被删除
            if(hasSingle.getDelFlag() == DEL){
                single.setId(hasSingle.getId());
                Integer rows = singleMapper.updateByPrimaryKey(single);
                if(rows == 1){
                    result = "ok";
                }
            }else{
                //已存在但未删除
                result = "exist";
            }

        }else{
            Integer rows = singleMapper.insertSelective(single);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
    * 根据条件查询所有单选题
    * */
    @Override
    public List<Map> getSingleAllBySelective(String title, Integer qtype) {
        if(StringUtils.isNotBlank(title)){
            title = "%"+title+"%";
        }
        return singleMapper.selectAllBySelective(title, qtype);
    }
    /*
    * 根据id查询单选题
    * */
    @Override
    public QuestionSingle getSingleById(Integer id) {
        return singleMapper.selectByPrimaryKey(id);
    }
    /*
    * 更新单选题
    * */
    @Override
    public String updateSingle(QuestionSingle single,HttpSession session) {
        String result = "error";
        QuestionSingle hasQs = singleMapper.selectByTitleWithoutSelf(single);
        if(hasQs != null){
            result = "exist";
        }else {
            Teacher teacher = (Teacher) session.getAttribute("user");
            single.setFkTeacher(teacher.getId());
            Integer rows = singleMapper.updateByPrimaryKeySelective(single);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
    * 删除单选题
    * */
    @Override
    public String deleteSingle(Integer sid) {
        QuestionSingle single = new QuestionSingle();
        single.setId(sid);
        single.setDelFlag(DEL);
        Integer rows = singleMapper.updateByPrimaryKeySelective(single);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    /*
    * 通过试卷ID查询所有单选题
    * */
    @Override
    public List<QuestionSingle> getSingleAllByExamId(Integer examId) {
        return singleMapper.selectAllByExamId(examId);
    }
}
