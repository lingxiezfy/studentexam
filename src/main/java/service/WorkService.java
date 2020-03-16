package service;

import entity.Work;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface WorkService {
    public String saveWork(Work work, HttpSession session);

    public List<Work> getWorkAllBySelective(String title);

    public Work getWorkId(Integer eid);

    public String updateWork(Work work, HttpSession session);

    public String deleteWork(Integer id);

    public List<Map> getWorksByStudent(Integer studentId);

    public String updateStatus(Integer eid, Date endTime, Integer status);
//
//    public String updateWorkPoints(Integer fkQuestions, Integer qtype, Integer workId, Double oldPoints);

//    public Map<String,Object> marking(WorkAnswer answerVO, Integer studentId);
}
