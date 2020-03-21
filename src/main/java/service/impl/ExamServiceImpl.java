package service.impl;

import dto.GeneratePaperOption;
import entity.*;
import mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ExamService;

import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

@Service
public class ExamServiceImpl implements ExamService {
    @Autowired
    private ExamMapper examMapper;
    @Autowired
    private QuestionSingleMapper singleMapper;
    @Autowired
    private QuestionMultiMapper multiMapper;
    @Autowired
    private QuestionJudgeMapper judgeMapper;
    @Autowired
    private ExamResultMapper resultMapper;
    @Autowired
    private ExamResultQuestionMapper resultQuestionMapper;
    @Autowired
    private ExamQuestionsMapper questionsMapper;


    private final byte ADD = 0;
    private final byte DEL = 1;
    private final int UNINIT = 1; //未初始化
    private final int UNRUNNING = 2; //未运行
    private final int RUNNING = 3; //正在运行

    /*
    *添加试卷
    * */
    @Override
    public String saveExam(Exam exam, GeneratePaperOption generateOption, HttpSession session) {
        String result = "error";
        //判断试卷是否存在
        Exam hasExam = examMapper.selectByTitle(exam.getTitle());
        if(hasExam != null && hasExam.getDelFlag() == ADD){
            result = "exist";
        }else {
            //添加
            exam.setDelFlag(ADD);
            Teacher teacher = (Teacher)session.getAttribute("user");
            exam.setFkTeacher(teacher.getId());
            exam.setFkStatus(UNINIT);
            if(examMapper.insertSelective(exam) > 0){
                if(Objects.nonNull(generateOption) && generateOption.isAutoGenerate()){
                    //获取试卷题型的总分数
                    AtomicReference<Double> singlePoints = new AtomicReference<>(0.0);
                    AtomicReference<Double> multiPoints = new AtomicReference<>(0.0);
                    AtomicReference<Double> judgePoints = new AtomicReference<>(0.0);
                    Double totalPoints = 0.0;
                    if (generateOption.getSingleCount() > 0) {
                        List<QuestionSingle> list = singleMapper.selectRandomAvailableCount(generateOption.getSingleCount());
                        list.forEach(question->{
                            ExamQuestions examQuestion = new ExamQuestions();
                            examQuestion.setFkExam(exam.getId());
                            examQuestion.setFkQuestion(question.getId());
                            examQuestion.setFkQtype(1);
                            if (questionsMapper.insertSelective(examQuestion) > 0) {
                                singlePoints.updateAndGet(v -> v + (question.getScore() == null ? 0 : question.getScore()));
                            }
                        });
                    }
                    if (generateOption.getMultiCount() > 0) {
                        List<QuestionMulti> list = multiMapper.selectRandomAvailableCount(generateOption.getSingleCount());
                        list.forEach(question->{
                            ExamQuestions examQuestion = new ExamQuestions();
                            examQuestion.setFkExam(exam.getId());
                            examQuestion.setFkQuestion(question.getId());
                            examQuestion.setFkQtype(2);
                            if (questionsMapper.insertSelective(examQuestion) > 0) {
                                multiPoints.updateAndGet(v -> v + (question.getScore() == null ? 0 : question.getScore()));
                            }
                        });
                    }
                    if (generateOption.getJudgeCount() > 0) {
                        List<QuestionJudge> list = judgeMapper.selectRandomAvailableCount(generateOption.getSingleCount());
                        list.forEach(question->{
                            ExamQuestions examQuestion = new ExamQuestions();
                            examQuestion.setFkExam(exam.getId());
                            examQuestion.setFkQuestion(question.getId());
                            examQuestion.setFkQtype(3);
                            if (questionsMapper.insertSelective(examQuestion) > 0) {
                                judgePoints.updateAndGet(v -> v + (question.getScore() == null ? 0 : question.getScore()));
                            }
                        });
                    }
                    totalPoints = singlePoints.get() + multiPoints.get() + judgePoints.get();
                    if(totalPoints.compareTo(0.0) > 0){
                        Exam updateExam = new Exam();
                        updateExam.setId(exam.getId());
                        updateExam.setSinglePoints(singlePoints.get());;
                        updateExam.setMultiPoints(multiPoints.get());
                        updateExam.setJudgePoints(judgePoints.get());
                        updateExam.setTotalPoints(totalPoints);
                        updateExam.setFkStatus(2);
                        examMapper.updateByPrimaryKeySelective(updateExam);
                    }
                }
                result = "ok";
            }
        }
        return result;
    }
    /*
     *根据条件查询所有试卷列表
     * */
    @Override
    public List<Exam> getExamAllBySelective(String title) {
        return examMapper.selectAllBySelective(title);
    }
    /*
     *根据ID查询试卷信息
     * */
    @Override
    public Exam getExamId(Integer eid) {
        return examMapper.selectByPrimaryKey(eid);
    }
    /*
     *编辑试卷信息
     * */
    @Override
    public String updateExam(Exam exam, HttpSession session) {
        String result = "error";
        //判断试卷名称是否存在
        Exam hasExam = examMapper.selectByTitleWithoutSelf(exam.getTitle(),exam.getId());
        if(hasExam != null){
            result =  "exist";
        }else {
            //获取当前登录用户
            Teacher teacher = (Teacher)session.getAttribute("user");
            exam.setFkTeacher(teacher.getId());
            Integer rows = examMapper.updateByPrimaryKeySelective(exam);
            if(rows == 1){
                result = "ok";
            }
        }
        return result;
    }
    /*
     *删除试卷信息
     * */
    @Override
    public String deleteExam(Integer id) {
        Exam exam = new Exam();
        exam.setId(id);
        exam.setDelFlag(DEL);
        Integer rows = examMapper.updateByPrimaryKeySelective(exam);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    /*
    * 根据学生ID查询当前应该参加的考试列表
    * */
    @Override
    public List<Map> getExamsByStudent(Integer studentId) {
        return examMapper.selectByStudent(studentId);
    }
    /*
     *设置正在运行
     * */
    @Override
    public String updateStatus(Integer eid, Date endTime, Integer status) {
        Exam exam = new Exam();
        exam.setId(eid);
        if(endTime != null){
            exam.setEndTime(endTime);
        }
        exam.setFkStatus(status);//运行状态
        Integer rows = examMapper.updateByPrimaryKeySelective(exam);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    /*
     *更新试卷题目总分
     * */
    @Override
    public String updateExamPoints(Integer fkQuestions, Integer qtype, Integer examId, Double oldPoints) {
        Exam exam = examMapper.selectByPrimaryKey(examId);
        Double totalPoints = exam.getTotalPoints();
        if(qtype == 1){
            //单选
            Double singlePoints = exam.getSinglePoints();
            //从总分中减去该题原来的分值
            singlePoints -= oldPoints;
            totalPoints -= oldPoints;
            //获取该题的当前分值
            QuestionSingle single = singleMapper.selectByPrimaryKey(fkQuestions);
            //加上新的分值
            singlePoints += single.getScore();
            totalPoints += single.getScore();
            exam.setSinglePoints(singlePoints);
        }else if(qtype == 2){
            //多选
            Double multiPoints = exam.getMultiPoints();
            //从总分中减去该题原来的分值
            multiPoints -= oldPoints;
            totalPoints -= oldPoints;
            //获取该题的当前分值
            QuestionMulti multi = multiMapper.selectByPrimaryKey(fkQuestions);
            //加上新的分值
            multiPoints += multi.getScore();
            totalPoints += multi.getScore();
            exam.setMultiPoints(multiPoints);
        }else if(qtype == 3){
            //判断
            Double judgePoints = exam.getJudgePoints();
            //从总分中减去该题原来的分值
            judgePoints -= oldPoints;
            totalPoints -= oldPoints;
            //获取该题的当前分值
            QuestionJudge judge = judgeMapper.selectByPrimaryKey(fkQuestions);
            //加上新的分值
            judgePoints += judge.getScore();
            totalPoints += judge.getScore();
            exam.setJudgePoints(judgePoints);
        }
        exam.setTotalPoints(totalPoints);
        Integer rows = examMapper.updateByPrimaryKeySelective(exam);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
    /*
    * 提交试卷并批阅
    * */
    @Override
    public Map<String, Object> marking(ExamAnswer answerVO, Integer studentId) {
        //存放返回值msg和points
        Map<String,Object> map = new HashMap<String, Object>();
        //获取试卷信息
        Exam exam = examMapper.selectByPrimaryKey(answerVO.getExamId());
        //创建考试结果
        ExamResult examResult = new ExamResult();
        examResult.setFkExam(exam.getId());
        examResult.setExamTitle(exam.getTitle());
        examResult.setFkStudent(studentId);
        examResult.setTime(new Date()); //当前时间
        //保存考试结果
        Integer rows = resultMapper.insertSelective(examResult);
        if(rows == 1){
            //获取答题的结果信息
            examResult = resultMapper.selectByFkExamAndFkStudent(examResult);
            Double points = calculatePoints(exam.getId(),answerVO,examResult);
            map.put("msg","ok");
            map.put("points",points);
        }else {
            map.put("msg","error");
        }
        return map;
    }
    /*
     * 计算单选得分
     * */
    public Double markSinglePoints(ArrayList<Integer> singleIDs,ExamAnswer answerVO,Integer examResultId,Double points){
        if(!singleIDs.isEmpty()){
            //查询单选题信息
            List<QuestionSingle>  singles = singleMapper.selectByIDs(singleIDs);
            //遍历所有的单选题
            for(QuestionSingle single:singles){
                //创建批改记录
                ExamResultQuestion erq = new ExamResultQuestion();
                erq.setFkQtype(1);
                erq.setFkQuestion(single.getId());
                //答题信息对应考试结果
                erq.setFkExamResult(examResultId);
                //根据题目id获取学生的答案进行答案比对
                //根据题目ID得到学生答案
                String studentAnswer = answerVO.getSingles().get(single.getId());
                if(single.getAnswer().equals(studentAnswer)){
                    //匹配正确
                    erq.setIsRight(true);
                    points += single.getScore();
                }else {
                    //匹配错误
                    erq.setIsRight(false);
                    //错误答案
                    erq.setWrongAnswer(studentAnswer);
                }
                resultQuestionMapper.insertSelective(erq);
            }
        }
        return points;
    }
    /*
     * 计算多选得分
     * */
    public Double markMultiPoints(ArrayList<Integer> multiIDs,ExamAnswer answerVO,Integer examResultId,Double points){
        if(!multiIDs.isEmpty()){
            //多选信息
            List<QuestionMulti> multis = multiMapper.selectByIDs(multiIDs);
            //遍历
            for(QuestionMulti multi : multis){
                //创建批改记录
                ExamResultQuestion erq = new ExamResultQuestion();
                erq.setFkQtype(2);
                erq.setFkQuestion(multi.getId());
                erq.setFkExamResult(examResultId);
                //根据题目id获取学生的答案进行答案比对
                //根据题目ID得到学生答案
                String studentAnswer = answerVO.getMultis().get(multi.getId());
                if(multi.getAnswer().equals(studentAnswer)){
                    //正确
                    erq.setIsRight(true);
                    points += multi.getScore();
                }else {
                    //错误
                    erq.setIsRight(false);
                    erq.setWrongAnswer(studentAnswer);
                }
                resultQuestionMapper.insertSelective(erq);
            }
        }
        return points;
    }
    /*
     * 计算判断得分
     * */
    public Double markJudgePoints(ArrayList<Integer> judgeIDs,ExamAnswer answerVO,Integer examResultId,Double points){
        if(!judgeIDs.isEmpty()){
            //判断
            List<QuestionJudge> judges = judgeMapper.selectByIDs(judgeIDs);
            //遍历
            for(QuestionJudge judge : judges){
                //创建批改记录
                ExamResultQuestion erq = new ExamResultQuestion();
                erq.setFkQtype(3);
                erq.setFkQuestion(judge.getId());
                erq.setFkExamResult(examResultId);
                //根据题目id获取学生的答案进行答案比对
                //根据题目ID得到学生答案
                String studentAnswer = answerVO.getJudges().get(judge.getId());
                if(judge.getAnswer().equals(studentAnswer)){
                    //正确
                    erq.setIsRight(true);
                    points += judge.getScore();
                }else {
                    //错误
                    erq.setIsRight(false);
                    erq.setWrongAnswer(studentAnswer);
                }
                resultQuestionMapper.insertSelective(erq);
            }
        }
        return points;
    }
    /*
    * 计算总分并保存答题信息
    * */
    public Double calculatePoints(Integer examId,ExamAnswer answerVO,ExamResult examResult){
        //总得分
        Double points = 0.0;
        //查询试卷所有试题
        List<Map> questions = questionsMapper.selectAllByExamId(examId);
        //存储题目的ID
        ArrayList<Integer> singleIDs = new ArrayList<>();
        ArrayList<Integer> multiIDs = new ArrayList<>();
        ArrayList<Integer> judgeIDs = new ArrayList<>();
        //根据体型分类ID
        for(Map q:questions){
            if("1".equals(q.get("fkQtype").toString())){
                singleIDs.add((Integer)q.get("fkQuestion"));
            }else if("2".equals(q.get("fkQtype").toString())){
                multiIDs.add((Integer)q.get("fkQuestion"));
            }else if("3".equals(q.get("fkQtype").toString())){
                judgeIDs.add((Integer)q.get("fkQuestion"));
            }
        }
        //单选得分
        points = markSinglePoints(singleIDs,answerVO,examResult.getId(),points);
        //多选
        points = markMultiPoints(multiIDs,answerVO,examResult.getId(),points);
        //判断
        points = markJudgePoints(judgeIDs,answerVO,examResult.getId(),points);
        //更新试卷结果表总得分
        examResult.setPoint(points);
        resultMapper.updateByPrimaryKeySelective(examResult);
        //返回总分
        return points;
    }
}
