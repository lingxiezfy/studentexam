package service;

import java.util.List;
import java.util.Map;

public interface ExamResultService {
    public List<Map> getExamHistoryBySelective(String title,Integer studentId);
}
