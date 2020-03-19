package mapper;

import entity.QuestionJudge;
import entity.QuestionSingle;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface QuestionJudgeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionJudge record);

    int insertSelective(QuestionJudge record);

    QuestionJudge selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionJudge record);

    int updateByPrimaryKey(QuestionJudge record);
    //根据条件查询判断题
    QuestionJudge selectByTitle(String title);
    //根据条件查询所有判断题
    List<Map> selectAllBySelective(@Param("title") String title, @Param("qtype") Integer qtype);
    //更新判断题
    QuestionJudge selectByTitleWithoutSelf(QuestionJudge judge);
    //根据ID查询
    List<QuestionJudge> selectAllByExamId(Integer examId);
    //ID所有
    List<QuestionJudge> selectByIDs(@Param("ids") ArrayList<Integer> ids);

    /**
     * 统计可用的题目数量
     */
    int countAvailableQuestion();
    /**
     * 随机选择 count 题可用的单选题
     */
    List<QuestionJudge> selectRandomAvailableCount(@Param("count") Integer count);
}