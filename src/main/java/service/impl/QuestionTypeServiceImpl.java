package service.impl;

import entity.QuestionType;
import mapper.QuestionTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.QuestionTypeService;

import java.util.List;
@Service
public class QuestionTypeServiceImpl implements QuestionTypeService {
    @Autowired
    private QuestionTypeMapper typeMapper;
    /*
    * 获取题型
    * */
    @Override
    public List<QuestionType> getQuestionTypeAll() {
        return typeMapper.selectAll();
    }
}
