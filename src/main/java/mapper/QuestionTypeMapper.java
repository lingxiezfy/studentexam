package mapper;

import entity.QuestionSingle;
import entity.QuestionType;

import java.util.List;

public interface QuestionTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionType record);

    int insertSelective(QuestionType record);

    QuestionType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionType record);

    int updateByPrimaryKey(QuestionType record);

    List<QuestionType> selectAll();

}