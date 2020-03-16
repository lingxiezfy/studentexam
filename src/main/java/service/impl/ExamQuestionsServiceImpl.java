package service.impl;

import entity.*;
import mapper.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ExamQuestionsService;

import java.util.List;
import java.util.Map;

@Service
public class ExamQuestionsServiceImpl implements ExamQuestionsService {
    @Autowired
    private ExamQuestionsMapper questionsMapper;
    @Autowired
    private ExamMapper examMapper;
    @Autowired
    private QuestionSingleMapper singleMapper;
    @Autowired
    private QuestionMultiMapper multiMapper;
    @Autowired
    private QuestionJudgeMapper judgeMapper;

    private final byte ADD = 0;
    private final byte DEL = 1;

//    @Override
//    public Integer saveQuestions(String ids, Integer eid, Integer qtype) {
//        int num = 0;
//        String[] idStrs = ids.split(",");
//        for(String id :idStrs){
//            //判断题目是否已经添加过
//                Integer fkQuestion = Integer.parseInt(id);
//                ExamQuestions eq = new ExamQuestions();
//                eq.setFkQuestion(fkQuestion);
//                eq.setFkExam(eid);
//                eq.setFkQtype(qtype);
//                ExamQuestions hasEq = questionsMapper.selectExist(eq);
//                if(hasEq != null){
//                    //已存在但被删除
//                    if(hasEq.getDelFlag() == DEL){
//                        hasEq.setDelFlag(ADD);
//                        Integer rows = questionsMapper.updateByPrimaryKeySelective(hasEq);
//                        if(rows == 1){
//                            num++;
//                        }else {
//                            num = 0;
//                        }
//                    }
//                }else {
//                    //添加
//                    Integer rows = questionsMapper.insertSelective(eq);
//                    if(rows == 1){
//                        num++;
//                    }else {
//                        num = 0;
//                    }
//                }
//        }
//        return num;
//    }
    /*
    * 添加试卷试题
    * */
    @Override
    public Integer saveQuestions(String ids, Integer eid, Integer qtype) {
        int num = 0;
        //查询试卷信息
        Exam exam = examMapper.selectByPrimaryKey(eid);
        //获取试卷题型的总分数
        Double singlePoints = exam.getSinglePoints() == null ? 0 : exam.getSinglePoints();
        Double multiPoints = exam.getMultiPoints() == null ? 0 : exam.getMultiPoints();
        Double judgePoints = exam.getJudgePoints() == null ? 0 : exam.getJudgePoints();
        Double totalPoints = exam.getTotalPoints()  == null ? 0 : exam.getTotalPoints();
        if(StringUtils.isNotBlank(ids)){
            //将选中的题目拆分为数组
            String[] idStrs = ids.split(",");
            for(String id :idStrs){
                //判断题目是否已经添加过
                Integer fkQuestion = Integer.parseInt(id);
                ExamQuestions eq = new ExamQuestions();
                eq.setFkQuestion(fkQuestion);
                eq.setFkExam(eid);
                eq.setFkQtype(qtype);
                ExamQuestions hasEq = questionsMapper.selectExist(eq);
                if(hasEq != null){
                    if(hasEq.getDelFlag() == DEL){
                        //已存在但被删除
                        hasEq.setDelFlag(ADD);
                        Integer rows = questionsMapper.updateByPrimaryKeySelective(hasEq);
                        if(rows == 1){
                            num++;
                            //添加成功则开始计算总分
                            Double points = getPoints(fkQuestion,qtype);
                            if(qtype == 1){
                                singlePoints += points;
                            }else if (qtype == 2){
                                multiPoints += points;
                            }else if (qtype == 3){
                                judgePoints += points;
                            }
                            totalPoints +=points;
                        }else {
                            num = 0;
                        }
                    }
                }else {
                    //添加
                    Integer rows = questionsMapper.insertSelective(eq);
                    if(rows == 1){
                        num++;
                        Double points = getPoints(fkQuestion,qtype);
                        if(qtype == 1){
                            singlePoints += points;
                        }else if (qtype == 2){
                            multiPoints += points;
                        }else if (qtype == 3){
                            judgePoints += points;
                        }
                        totalPoints +=points;
                    }else {
                        num = 0;
                    }
                }
            }
            //更新试卷表中的总分及状态
            if(num > 0){
                exam.setSinglePoints(singlePoints);;
                exam.setMultiPoints(multiPoints);
                exam.setJudgePoints(judgePoints);
                exam.setTotalPoints(totalPoints);
                exam.setFkStatus(2);
                Integer rows = examMapper.updateByPrimaryKeySelective(exam);
                if(rows == 0){
                   num = 0;
                }
            }

        }

        return num;
    }
    /*
    * 查询所有试题
    * */
    @Override
    public List<Map> getExamAllByExamId(Integer examId) {
        return questionsMapper.selectAllByExamId(examId);
    }
    /*
     * 删除试题并修改总分
     * */
    @Override
    public String deleteExamQuestions(Integer id, Integer fkQuestion, Integer fkQtype, Integer fkExam) {
        String result = "error";
        ExamQuestions eq = new ExamQuestions();
        eq.setId(id);
        eq.setDelFlag(DEL);
        Integer rows = questionsMapper.updateByPrimaryKeySelective(eq);
        if(rows == 1){
            //获取分值，删除成功减掉总分
            Double points = getPoints(fkQuestion,fkQtype);
            Exam exam = examMapper.selectByPrimaryKey(fkExam);
            if(exam != null){
                if(fkQtype == 1){
                    Double singlePoints = exam.getSinglePoints();
                    if(singlePoints <= 0){
                        singlePoints = 0.0;
                    }else {
                        singlePoints -= points;
                    }
                    exam.setSinglePoints(singlePoints);
                }else if (fkQtype == 2){
                    Double multiPoints = exam.getMultiPoints();
                    if(multiPoints <= 0){
                        multiPoints = 0.0;
                    }else {
                        multiPoints -= points;
                    }
                    exam.setMultiPoints(multiPoints);
                }else if(fkQtype == 3){
                    Double judgePoints = exam.getJudgePoints();
                    if(judgePoints <= 0){
                        judgePoints = 0.0;
                    }else {
                        judgePoints -= points;
                    }
                    exam.setJudgePoints(judgePoints);
                }
                Double totalPoints = exam.getTotalPoints();
                if(totalPoints <= 0){
                    totalPoints = 0.0;
                }else {
                    totalPoints -= points;
                }
                exam.setTotalPoints(totalPoints);
                Integer count = examMapper.updateByPrimaryKeySelective(exam);
                if(count == 1){
                    result = "ok";
                }
            }
        }
        return result;
    }

    /*
    * 计算总分
    * */
    public  Double getPoints(Integer id,Integer qtype){
        Double points = 0.0;
        if(qtype == 1){
            //单选
            QuestionSingle qs = singleMapper.selectByPrimaryKey(id);
            if(qs != null){
                points = qs.getScore();
            }
        }else if(qtype == 2){
            //多选
            QuestionMulti qu = multiMapper.selectByPrimaryKey(id);
            if(qu != null){
                points = qu.getScore();
            }
        }else if(qtype == 3){
            //判断
            QuestionJudge qj = judgeMapper.selectByPrimaryKey(id);
            if(qj != null){
                points = qj.getScore();
            }
        }
        return points;
    }
}
