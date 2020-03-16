package service.impl;

import entity.QuestionJudge;
import entity.Teacher;
import mapper.QuestionJudgeMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.QuestionJudgeService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
@Service
public class QuestionJudgeServiceImpl implements QuestionJudgeService {
    @Autowired
    private QuestionJudgeMapper judgeMapper;

    private final int SINGLE = 1;
    private final int MULTI = 2;
    private final int JUDGE = 3;
    private final byte ADD = 0;
    private final byte DEL = 1;
    /*
     * 保存判断题
     * */
    @Override
    public String saveJudge(QuestionJudge judge, HttpSession session) {
        String result = "error";
        //设置题目类型
        judge.setFkQtype(JUDGE);
        //出题人
        Teacher teacher = (Teacher) session.getAttribute("user");
        judge.setFkTeacher(teacher.getId());
        //删除标识
        judge.setDelFlag(ADD);
        //判断该题是否存在
        QuestionJudge hasJudge = judgeMapper.selectByTitle(judge.getTitle());
        if(hasJudge != null){
            if(hasJudge.getDelFlag() == DEL){
                //存在但是被删除
                judge.setId(hasJudge.getId());
                Integer rows = judgeMapper.updateByPrimaryKey(judge);
                if(rows == 1){
                    result = "ok";
                }
            }else {
                //已存在但未删除
                result = "exist";
            }
        }else {
            Integer rows = judgeMapper.insertSelective(judge);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     * 根据条件查询所有判断题
     * */
    @Override
    public List<Map> getjudgeAllBySelective(String title, Integer qtype) {
        if(StringUtils.isNotBlank(title)){
            title = "%"+title+"%";
        }
        return judgeMapper.selectAllBySelective(title, qtype);
    }
    /*
     * 根据id查询判断题
     * */
    @Override
    public QuestionJudge getJudgeById(Integer id) {
        return judgeMapper.selectByPrimaryKey(id);
    }
    /*
     * 更新判断题
     * */
    @Override
    public String updateJudge(QuestionJudge judge, HttpSession session) {
        String result = "error";
        QuestionJudge hasJudge = judgeMapper.selectByTitleWithoutSelf(judge);
        if(hasJudge != null){
            result = "exist";
        }else {
            Teacher teacher = (Teacher) session.getAttribute("user");
            judge.setFkTeacher(teacher.getId());
            Integer rows = judgeMapper.updateByPrimaryKeySelective(judge);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     * 删除判断题
     * */
    @Override
    public String deleteJudge(Integer jid) {
        QuestionJudge judge = new QuestionJudge();
        judge.setId(jid);
        judge.setDelFlag(DEL);
        Integer rows = judgeMapper.updateByPrimaryKeySelective(judge);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    /*
     * 通过试卷ID查询所有判断题
     * */
    @Override
    public List<QuestionJudge> getJudgeAllByExamId(Integer examId) {
        return judgeMapper.selectAllByExamId(examId);
    }
}
