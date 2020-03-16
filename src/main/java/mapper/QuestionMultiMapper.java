package mapper;

import entity.QuestionMulti;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface QuestionMultiMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionMulti record);

    int insertSelective(QuestionMulti record);

    QuestionMulti selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionMulti record);

    int updateByPrimaryKey(QuestionMulti record);
    //根据题目查询多选题
    QuestionMulti selectByTitle(String title);
    //根据条件查询所有的多选题
    List<Map> selectAllBySelective(@Param("title") String title,@Param("qtype") Integer qtype);
    //除了自身是否还有相同的题目
    QuestionMulti selectByTitleWithoutSelf(QuestionMulti questionMulti);
    //根据ID
    List<QuestionMulti> selectAllByExamId(Integer examId);
    //根据ID所有的多选
    List<QuestionMulti> selectByIDs(@Param("ids") ArrayList<Integer> ids);
}