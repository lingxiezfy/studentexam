package web;

import dto.message.MessageTypeEnum;
import entity.Manager;
import entity.Student;
import entity.Teacher;
import entity.TeacherClazz;
import mapper.ClazzMapper;
import mapper.MessageMapper;
import mapper.TeacherClazzMapper;
import mapper.TeacherMapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.socket.SocketServer;
import web.manager.UserCommon;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/3/28 22:02 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@RequestMapping("notice")
@Controller
public class NoticeController {

    @Autowired
    MessageMapper messageMapper;
    @Autowired
    TeacherClazzMapper teacherClazzMapper;

    @RequestMapping("toPublish")
    public String toPublish(){
        return "notice/publish_page";
    }

    @RequestMapping("publish")
    @ResponseBody
    public Map<String,Object> publish(HttpSession session, String title, String content){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        if(StringUtils.isBlank(title)){
            response.put("message","标题不能为空");
            return response;
        }
        if(StringUtils.isBlank(content)){
            response.put("message","内容不能为空");
            return response;
        }
        Integer roleId = (Integer)session.getAttribute("role");
        Object user = session.getAttribute("user");
        UserCommon userCommon = (UserCommon) session.getAttribute("userCommon");
        if(userCommon == null || userCommon.getRole() == 1){
            response.put("message","无权操作");
            return response;
        }
        if(roleId == 2){
            List<TeacherClazz> classList =  teacherClazzMapper.selectTeachClass(userCommon.getId());
            classList.forEach(teacherClazz -> {
                SocketServer.sendToGroup(userCommon,teacherClazz.getFkClazz(), MessageTypeEnum.ClassNotice,title,content,0);
            });
            response.put("success",true);
            response.put("message","发送成功");
            return response;
        }
        if(roleId == 3){
            SocketServer.sendSystemNotice(userCommon,title,content,0);
            response.put("success",true);
            response.put("message","发送成功");
            return response;
        }
        response.put("message","无权操作");
        return response;
    }
}
