package service.impl;

import entity.*;
import mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.WorkService;

import javax.servlet.http.HttpSession;
import java.util.*;

@Service
public class WorkServiceImpl implements WorkService {
    @Autowired
    private WorkMapper workMapper;


    private final byte ADD = 0;
    private final byte DEL = 1;
    private final int UNINIT = 1; //未初始化
    private final int UNRUNNING = 2; //未运行
    private final int RUNNING = 3; //正在运行

    /*
    *添加试卷
    * */
    @Override
    public String saveWork(Work work, HttpSession session) {
        String result = "error";
        //判断试卷是否存在
        Work hasWork = workMapper.selectByTitle(work.getTitle());
        if(hasWork != null && hasWork.getDelFlag() == ADD){
            result = "exist";
        }else {
            //添加
            work.setDelFlag(ADD);
            Teacher teacher = (Teacher)session.getAttribute("user");
            work.setFkTeacher(teacher.getId());
            work.setFkStatus(UNINIT);
            workMapper.insertSelective(work);
            result = "ok";
        }
        return result;
    }
    /*
     *根据条件查询所有试卷列表
     * */
    @Override
    public List<Work> getWorkAllBySelective(String title) {
        return workMapper.selectAllBySelective(title);
    }
    /*
     *根据ID查询试卷信息
     * */
    @Override
    public Work getWorkId(Integer eid) {
        return workMapper.selectByPrimaryKey(eid);
    }
    /*
     *编辑试卷信息
     * */
    @Override
    public String updateWork(Work work, HttpSession session) {
        String result = "error";
        //判断试卷名称是否存在
        Work hasWork = workMapper.selectByTitleWithoutSelf(work.getTitle(),work.getId());
        if(hasWork != null){
            result =  "exist";
        }else {
            //获取当前登录用户
            Teacher teacher = (Teacher)session.getAttribute("user");
            work.setFkTeacher(teacher.getId());
            Integer rows = workMapper.updateByPrimaryKeySelective(work);
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
    public String deleteWork(Integer id) {
        Work work = new Work();
        work.setId(id);
        work.setDelFlag(DEL);
        Integer rows = workMapper.updateByPrimaryKeySelective(work);
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
    public List<Map> getWorksByStudent(Integer studentId) {
        return workMapper.selectByStudent(studentId);
    }
    /*
     *设置正在运行
     * */
    @Override
    public String updateStatus(Integer eid, Date endTime, Integer status) {
        Work work = new Work();
        work.setId(eid);
        if(endTime != null){
            work.setEndTime(endTime);
        }
        work.setFkStatus(status);//运行状态
        Integer rows = workMapper.updateByPrimaryKeySelective(work);
        if(rows == 1){
            return "ok";
        }else {
            return "error";
        }
    }
}
