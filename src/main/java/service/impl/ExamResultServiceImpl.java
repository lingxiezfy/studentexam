package service.impl;

import mapper.ExamResultMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.ExamResultService;

import java.util.List;
import java.util.Map;
@Service
public class ExamResultServiceImpl implements ExamResultService {
    @Autowired
    private ExamResultMapper resultMapper;
    /*
    * 根据条件查询考试记录
    * */
    @Override
    public List<Map> getExamHistoryBySelective(String title,Integer studentId) {
        if(StringUtils.isNotBlank(title)){
            title = "%"+title+"%";
        }
        List<Map> list = resultMapper.selectByFkExamTitle(title,studentId);
        return list;
    }
}
