package service.socket;

import com.alibaba.fastjson.JSON;
import dto.message.MessageBase;
import dto.message.MessageTypeEnum;
import entity.Manager;
import entity.Student;
import entity.Teacher;
import mapper.ManagerMapper;
import mapper.StudentMapper;
import mapper.TeacherMapper;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import web.manager.UserCommon;

import javax.annotation.PostConstruct;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * [Create]
 * Description:
 * @version 1.0
 */
@ServerEndpoint(value = "/ws/server")
@Component
public class SocketServer {

    private static StudentMapper studentMapper;
    private static TeacherMapper teacherMapper;
    private static ManagerMapper managerMapper;

    @Autowired
    public void setStudentMapper(StudentMapper studentMapper) {
        SocketServer.studentMapper = studentMapper;
    }
    @Autowired
    public void setTeacherMapper(TeacherMapper teacherMapper) {
        SocketServer.teacherMapper = teacherMapper;
    }
    @Autowired
    public void setManagerMapper(ManagerMapper managerMapper) {
        SocketServer.managerMapper = managerMapper;
    }

    @PostConstruct
    public void init() {
        System.out.println("websocket 加载");
    }
    private static final Logger log = LoggerFactory.getLogger(SocketServer.class);
    private static final AtomicInteger OnlineCount = new AtomicInteger(0);
    // concurrent包的线程安全Set，用来存放每个客户端对应的Session对象。
    private static CopyOnWriteArraySet<Session> SessionSet = new CopyOnWriteArraySet<Session>();

    // 组内在线用户 （-1未分班级组；-2 教师；-3 管理员组；1-n 班级组）
    private static ConcurrentHashMap<Integer, CopyOnWriteArraySet<Session>> groupSessionMap = new ConcurrentHashMap<>();

    // 用户消息Session列表
    // 暂不实现私信，可以不需要该缓存
    // private static ConcurrentHashMap<UserCommon, CopyOnWriteArraySet<Session>> userSessionMap = new ConcurrentHashMap<>();

    // session 与用户绑定 （用于快速定位Session指向的用户）
    private static ConcurrentHashMap<Session, UserCommon> sessionUserMap = new ConcurrentHashMap<>();

    // session 与组绑定（用于快速定位Session指向的组）
    // 暂不实现组内聊天，可以不需要该缓存
    //private static ConcurrentHashMap<Session, Integer> sessionGroupMap = new ConcurrentHashMap<>();


    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        SessionSet.add(session);
        int cnt = OnlineCount.incrementAndGet(); // 在线数加1
        log.info("有连接加入，当前连接数为：{}", cnt);
    }

    /**
     * 生成组Id
     * @param user
     * @return
     */
    public static int generateGroupId(UserCommon user){
        int groupId = 0;
        if(user != null) {
            switch (user.getRole()) {
                // 学生
                case 1:
                    groupId = user.getClazzId() == 0 ? -1 : user.getClazzId();
                    break;
                // 教师
                case 2:
                    groupId = -2;
                    break;
                // 管理员
                case 3:
                    groupId = -3;
                    break;
            }
        }
        return groupId;
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        UserCommon user = sessionUserMap.remove(session);;
        if(user != null){
            int groupId = generateGroupId(user);
            CopyOnWriteArraySet<Session> set = groupSessionMap.get(groupId);
            if(set != null){
                set.remove(session);
            }
        }

        SessionSet.remove(session);
        int cnt = OnlineCount.decrementAndGet();
        log.info("有连接关闭，当前连接数为：{}", cnt);
    }


    private static UserCommon findUserByRoleAndId(int role,int id){
        UserCommon user = null;
        if(role == 1){
            Student student = studentMapper.selectByPrimaryKey(id);
            user = UserCommon.init(student);
        }
        if(role == 2){
            Teacher teacher = teacherMapper.selectByPrimaryKey(id);
            user = UserCommon.init(teacher);
        }
        if(role == 3){
            Manager manager = managerMapper.selectByPrimaryKey(id);
            user = UserCommon.init(manager);
        }
        return user;
    }

    /**
     * 收到客户端消息后调用的方法
     * group;{-1,-2,-3,classId};{in,msg};{role,title};{userId,message content}
     *
     * @param message
     *            客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("来自客户端的消息：{}",message);
        String[] arr = message.split(";",5);
        try {
            if (arr.length == 5) {
                if ("group".equals(arr[0])) {//组消息
                    int groupId = Integer.parseInt(arr[1]);
                    if ("in".equals(arr[2])) { // 用户绑定 group;{groupId};in;{role};{userId}
                        int roleId = Integer.parseInt(arr[3]);
                        int userId = Integer.parseInt(arr[4]);
                        UserCommon user = SocketServer.findUserByRoleAndId(roleId, userId);
                        if (user != null) {
                            int groupIdReal = generateGroupId(user);
                            if (groupIdReal == groupId) {
                                groupSessionMap.computeIfAbsent(groupId, k -> new CopyOnWriteArraySet<>()).add(session);
                                sessionUserMap.computeIfAbsent(session, k -> user);
                                log.info("用户{}:{}注册加入组{}", user.getId(), user.getName(), groupId);
                            }
                        } else {
                            log.error("用户注册失败，没找到该用户");
                        }
                    } else {
                        log.warn("未解析消息{}", message);
                    }
                } else {
                    log.warn("未解析消息{}", message);
                }
            }
        }catch (Exception e){
            log.error("消息解析异常，{}:{}，\r\n异常信息：{}",session,message,e);
        }
    }

    /**
     * 服务器主动推送系统通知(广播)
     */
    public static void sendSystemNotice(UserCommon admin,String title, String content,Integer messageId) {
        if(admin.getRole() != 3){
            log.error("{}无权限发送系统通知,消息内容{}:{}", admin,title,content);
            return;
        }
        if(StringUtils.isBlank(content)){
            log.error("{}空消息，禁止发送", admin);
            return;
        }
        String message = JSON.toJSONString(new MessageBase(admin, MessageTypeEnum.SystemNotice, title, content, new Date(), messageId));
        BroadCastInfo(message);
    }

    /**
     * 服务器推送群消息
     */
    public static void sendToGroup(UserCommon user, Integer groupId,MessageTypeEnum messageType, String title, String content, Integer messageId) {
        if(groupId == null || groupId == 0){
            log.error("发送消息失败，{}错误的讨论组",groupId);
            return;
        }
        CopyOnWriteArraySet<Session> groupSessions = groupSessionMap.get(groupId);
        if(groupSessions != null && groupSessions.size() > 0 && StringUtils.isNotBlank(content)){
            String message = JSON.toJSONString(new MessageBase(user, messageType,title,content,new Date(), messageId));
            for(Session session : groupSessions){
                if(session.isOpen()){
                    SendMessage(session,message);
                }
            }
        }
    }

    /**
     * 出现错误
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误：{}，Session ID： {}",error.getMessage(),session.getId());
    }

    /**
     * 发送消息，实践表明，每次浏览器刷新，session会发生变化。
     */
    public static void SendMessage(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            log.error("发送消息出错", e);
        }
    }

    /**
     * 群发消息
     * @param message
     */
    public static void BroadCastInfo(String message) {
        for (Session session : SessionSet) {
            if(session.isOpen()){
                SendMessage(session, message);
            }
        }
    }

    /**
     * 指定Session发送消息
     * @param sessionId
     * @param message
     * @throws IOException
     */
    public static void SendMessage(String message,String sessionId) throws IOException {
        Session session = null;
        for (Session s : SessionSet) {
            if(s.getId().equals(sessionId)){
                session = s;
                break;
            }
        }
        if(session!=null){
            SendMessage(session, message);
        }
        else{
            log.warn("没有找到你指定ID的会话：{}",sessionId);
        }
    }

}
