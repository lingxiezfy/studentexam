package mapper;

import entity.QuestionSingle;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface QuestionSingleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionSingle record);

    int insertSelective(QuestionSingle record);

    QuestionSingle selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionSingle record);

    int updateByPrimaryKey(QuestionSingle record);
    //根据条件查询单选题
    QuestionSingle selectByTitle(String title);
    //根据条件查询所有单选题
    List<Map> selectAllBySelective(@Param("title") String title,@Param("qtype") Integer qtype);
    //更新单选题
    QuestionSingle selectByTitleWithoutSelf(QuestionSingle single);
    //根据ID查询单选信息
    List<QuestionSingle> selectAllByExamId(Integer examId);
    //根据ID查询所有单选信息
    List<QuestionSingle> selectByIDs(@Param("ids")ArrayList<Integer> ids);

    /**
     * 统计可用的题目数量
     */
    int countAvailableQuestion();
    /**
     * 随机选择 count 题可用的单选题
     */
    List<QuestionSingle> selectRandomAvailableCount(@Param("count") Integer count);
}