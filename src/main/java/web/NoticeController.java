package web;

import dto.message.MessageRoleEnum;
import dto.message.MessageTypeEnum;
import entity.*;
import mapper.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import service.socket.SocketServer;
import web.manager.UserCommon;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static org.springframework.http.HttpMethod.*;

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
        UserCommon userCommon = (UserCommon) session.getAttribute("userCommon");
        if(userCommon == null || userCommon.getRole() == 1){
            response.put("message","无权操作");
            return response;
        }
        if(userCommon.getRole() == 2){
            List<TeacherClazz> classList =  teacherClazzMapper.selectTeachClass(userCommon.getId());
            classList.forEach(teacherClazz -> {
                Message message = new Message();
                message.setToRole(MessageRoleEnum.Clazz.getCode());
                message.setToId(teacherClazz.getFkClazz());
                message.setFromRole(userCommon.getRole());
                message.setFromId(userCommon.getId());
                message.setFromName(userCommon.getName());
                message.setMessageType(MessageTypeEnum.ClassNotice.getCode());
                message.setMessageTitle(title);
                message.setMessageContent(content);
                messageMapper.insertSelective(message);
                SocketServer.sendToGroup(userCommon,teacherClazz.getFkClazz(), MessageTypeEnum.ClassNotice,title,content,message.getMessageId());
            });
            response.put("success",true);
            response.put("message","发送成功");
            return response;
        }
        if(userCommon.getRole() == 3){
            Message message = new Message();
            message.setToRole(MessageRoleEnum.All.getCode());
            message.setToId(-1);
            message.setFromRole(userCommon.getRole());
            message.setFromId(userCommon.getId());
            message.setFromName(userCommon.getName());
            message.setMessageType(MessageTypeEnum.SystemNotice.getCode());
            message.setMessageTitle(title);
            message.setMessageContent(content);
            messageMapper.insertSelective(message);
            SocketServer.sendSystemNotice(userCommon,title,content,message.getMessageId());
            response.put("success",true);
            response.put("message","发送成功");
            return response;
        }
        response.put("message","无权操作");
        return response;
    }


    @Autowired
    StudentMapper studentMapper;
    @Autowired
    TeacherMapper teacherMapper;
    @Autowired
    ManagerMapper managerMapper;

    @RequestMapping("list")
    public String list(HttpSession session,Integer messageId,Integer teacherId,Integer messageType, Model model){
        UserCommon userCommon = (UserCommon) session.getAttribute("userCommon");

        Message queryMessage = new Message();
        if(messageId != null && messageId > 0){
            queryMessage.setMessageId(messageId);
        }
        if(userCommon.getClazzId() > 0 && messageType != null && messageType == MessageTypeEnum.ClassNotice.getCode()){
            List<Teacher> teacherList = teacherClazzMapper.selectTeacherByClazzId(userCommon.getClazzId());
            model.addAttribute("teacherList",teacherList);
        }
        if(messageType != null && messageType > 0){
            queryMessage.setMessageType(messageType);
            if(teacherId != null && teacherId > 0){
                queryMessage.setFromId(teacherId);
                queryMessage.setFromRole(2);
            }
        }
        List<Message> list = messageMapper.query(queryMessage,userCommon);
        model.addAttribute("teacherId",teacherId);
        model.addAttribute("messageType",messageType);
        model.addAttribute("messageList",list);
        return "notice/notice_list";
    }
}