package service;

import entity.ExamClazz;

import java.util.List;
import java.util.Map;

public interface ExamClazzService {
    public List<Map> getExamClazzAllByExamId(Integer fkExam);

    public String saveExamClazz(ExamClazz examClazz);

    public String deleteExamClazz(Integer id);
}
