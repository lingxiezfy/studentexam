package web;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import dto.community.*;
import dto.message.Group;
import entity.Clazz;
import entity.Post;
import entity.Reply;
import mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.CommunityService;
import service.socket.SocketServer;
import web.manager.UserCommon;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * [Create]
 * Description: 社区
 * <br/>Date: 2020/4/3 22:55 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */

@Controller
@RequestMapping("community")
public class CommunityController {

    @Autowired
    CommunityService communityService;

    @Autowired
    PostMapper postMapper;
    @Autowired
    TopicMapper topicMapper;
    @Autowired
    ReplyMapper replyMapper;


    @RequestMapping("list")
    public String list(HttpSession session, ListRequest request,Model model){
        Post queryPost = new Post();
        if(request.getTopic() > 0){
            queryPost.setTopicId(request.getTopic());
        }
        if(request.getExcellent() == 1){
            queryPost.setExcellentFlag(1);
        }
        queryPost.setDeleteFlag(0);
        Page page = PageHelper.startPage(request.getPageIndex(),request.getPageSize());
        if("newest".equals(request.getOrderBy())){
            PageHelper.orderBy("top_flag desc,excellent_flag desc,create_time desc");
        }else if("hottest".equals(request.getOrderBy())){
            PageHelper.orderBy("top_flag desc,excellent_flag desc,reply_count desc");
        }
        List<PostWithTopicName> postList = postMapper.query(queryPost);
        model.addAttribute("currPage",page.getPageNum());
        model.addAttribute("totalCount",page.getTotal());
        model.addAttribute("postList",postList);

        model.addAttribute("pageSize",request.getPageSize());
        model.addAttribute("topic",request.getTopic());
        model.addAttribute("excellent",request.getExcellent());
        model.addAttribute("orderBy",request.getOrderBy());

        model.addAttribute("hotList",communityService.getWeekHotPost());
        return "community/list";
    }

    @RequestMapping("user/{role}/{userId}/home")
    public String userHome(HttpSession session,@PathVariable("role") Integer role,@PathVariable("userId") Integer userId,PageRequest pageRequest, Model model){
        Post post = new Post();
        post.setUserRole(role);
        post.setUserId(userId);
        post.setDeleteFlag(0);
        Page page = PageHelper.startPage(pageRequest.getPageIndex(),pageRequest.getPageSize());
        PageHelper.orderBy("top_flag desc,excellent_flag desc,create_time desc");
        model.addAttribute("postList",postMapper.query(post));
        model.addAttribute("currPage",page.getPageNum());
        model.addAttribute("totalCount",page.getTotal());
        model.addAttribute("pageSize",pageRequest.getPageSize());
        return "community/user/home";
    }

    @Autowired
    TeacherMapper teacherMapper;
    @Autowired
    StudentMapper studentMapper;
    @Autowired
    ManagerMapper managerMapper;

    @RequestMapping("user/{role}/{userId}/index")
    public String userIndex(HttpSession session,@PathVariable("role") Integer role,@PathVariable("userId") Integer userId, Model model){
        UserCommon currUser = (UserCommon) session.getAttribute("userCommon");
        if(role == currUser.getRole() && userId == currUser.getId()){
            model.addAttribute("user",currUser);
        }else{
            switch (role){
                case 1:
                    model.addAttribute("user",UserCommon.init(studentMapper.selectByPrimaryKey(userId)));
                    break;
                case 2:
                    model.addAttribute("user",UserCommon.init(teacherMapper.selectByPrimaryKey(userId)));
                    break;
                case 3:
                    model.addAttribute("user",UserCommon.init(managerMapper.selectByPrimaryKey(userId)));
                    break;
                default:
                    break;
            }
        }
        Post post = new Post();
        post.setUserRole(role);
        post.setUserId(userId);
        post.setDeleteFlag(0);
        PageHelper.startPage(1,10);
        PageHelper.orderBy("create_time desc");
        model.addAttribute("postList",postMapper.query(post));

        Reply reply = new Reply();
        reply.setUserId(userId);
        reply.setUserRole(role);
        reply.setDeleteFlag(0);
        PageHelper.startPage(1,4);
        PageHelper.orderBy("reply.create_time desc");
        model.addAttribute("replyList",replyMapper.query(reply));
        return "community/user/index";
    }

    @RequestMapping("toAdd")
    public String toAdd(Model model){
        model.addAttribute("topicList",topicMapper.selectAllUseful());
        return "community/action/add";
    }

    @Autowired
    ClazzMapper clazzMapper;
    @Autowired
    TeacherClazzMapper teacherClazzMapper;

    @RequestMapping("buildFooter")
    public String buildFooter(HttpSession session, Model model){
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        // 获取用户可用群组
        List<Group> groupList = new ArrayList<>();
        switch (user.getRole()) {
            // 学生(以班级为单位)
            case 1:
                Group group = new Group();
                if(user.getClazzId() == 0){
                    group.setGroupId(-1);
                    group.setGroupName("未分班学生");
                }
                Clazz clazz = clazzMapper.selectByPrimaryKey(user.getClazzId());
                group.setGroupId(clazz.getId());
                group.setGroupName(clazz.getCno()+"班");
                groupList.add(group);
                break;
            // 教师（教师组和各自班级）
            case 2:
                Group group2 = new Group();
                group2.setGroupId(-2);
                group2.setGroupName("全体教师");
                groupList.add(group2);
                List<Map> classList = teacherClazzMapper.selectByFKTeacher(user.getId());
                classList.forEach(one->{
                    Group group3 = new Group();
                    group3.setGroupId((Integer) one.get("fk_clazz"));
                    group3.setGroupName(one.get("cno")+"班");
                    groupList.add(group3);
                });
                break;
            // 管理员（管理员组和教师组）
            case 3:
                Group group3 = new Group();
                group3.setGroupId(-3);
                group3.setGroupName("管理员组");
                groupList.add(group3);

                Group group4 = new Group();
                group4.setGroupId(-2);
                group4.setGroupName("全体教师");
                groupList.add(group4);
                break;
        }
        model.addAttribute("groupList", groupList);
        return "community/common/footer";
    }

    @RequestMapping("toEdit/{postId}")
    public String toEdit(Model model,@PathVariable("postId") Integer postId){
        model.addAttribute("topicList",topicMapper.selectAllUseful());
        model.addAttribute("post",postMapper.selectByPrimaryKey(postId));
        return "community/action/add";
    }

    @RequestMapping("save")
    public String save(HttpSession session,Post post){
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(post.getId() == null){
            post.setUserId(user.getId());
            post.setUserName(user.getName());
            post.setUserRole(user.getRole());
            postMapper.insertSelective(post);
        }else {
            postMapper.updateByPrimaryKeySelective(post);
        }
        return String.format("redirect:/community/user/%s/%s/home",user.getRole(),user.getId());
    }

    @RequestMapping("detail/{postId}")
    public String detail(Model model, @PathVariable("postId") Integer postId, PageRequest pageRequest){
        model.addAttribute("post",postMapper.selectByPrimaryKey(postId));

        Page page = PageHelper.startPage(pageRequest.getPageIndex(),pageRequest.getPageSize());
        model.addAttribute("replyList",replyMapper.selectByPostId(postId));
        model.addAttribute("currPage",page.getPageNum());
        model.addAttribute("totalCount",page.getTotal());
        model.addAttribute("pageSize",pageRequest.getPageSize());

        model.addAttribute("hotList",communityService.getWeekHotPost());
        return "community/action/detail";
    }

    @RequestMapping("post/del/{postId}")
    @ResponseBody
    public Map<String,Object> delPost(HttpSession session,@PathVariable("postId") Integer postId){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        Post post = postMapper.selectByPrimaryKey(postId);
        if(post == null){
            response.put("msg","帖子不存在");
            return response;
        }
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(user.getRole() == 3 || (user.getId() == post.getUserId() && user.getRole() == post.getUserRole())){
            if(post.getDeleteFlag() == 1){
                response.put("msg","帖子已经被删除了，无需重复删除");
                return response;
            }
            postMapper.deleteByPrimaryKey(postId);
            response.put("success",true);
            response.put("msg","成功");
        }else {
            response.put("msg","无权操作！");
        }
        return response;
    }

    @RequestMapping("post/set/{postId}")
    @ResponseBody
    public Map<String,Object> setPost(HttpSession session, @PathVariable("postId") Integer postId, PostSetRequest request){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        if(request.getField() == null || request.getRank() == null){
            response.put("msg","参数有误，请检查field和rank的值");
            return response;
        }
        Post post = postMapper.selectByPrimaryKey(postId);
        if(post == null){
            response.put("msg","帖子不存在");
            return response;
        }
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(user.getRole() == 3){
            if(post.getDeleteFlag() == 1){
                response.put("msg","帖子已经被删除了");
                return response;
            }
            Post upPost = new Post();
            upPost.setId(postId);
            switch (request.getField()){
                case "stick":
                    upPost.setTopFlag(request.getRank() == 1 ? 1 : 0);
                    break;
                case "status":
                    upPost.setExcellentFlag(request.getRank() == 1 ? 1 : 0);
                    break;
                default:
                    response.put("msg","参数有误:未支持的field");
                    return response;
            }
            postMapper.updateByPrimaryKeySelective(upPost);
            response.put("success",true);
            response.put("msg","成功");
        }else {
            response.put("msg","无权操作！");
        }
        return response;
    }

    @RequestMapping("reply/info/{replyId}")
    @ResponseBody
    public Map<String,Object> replyInfo(@PathVariable("replyId") Integer replyId){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        Reply reply = replyMapper.selectByPrimaryKey(replyId);
        if(reply == null || reply.getDeleteFlag() == 1){
            response.put("msg","评论不存在，请稍后再试");
        }
        response.put("data",reply);
        response.put("success",true);
        response.put("msg","成功");
        return response;
    }

    @RequestMapping("reply/del/{replyId}")
    @ResponseBody
    public Map<String,Object> delReply(HttpSession session,@PathVariable("replyId") Integer replyId){
        Map<String,Object> response = new HashMap<>();
        response.put("success",false);
        Reply reply = replyMapper.selectByPrimaryKey(replyId);
        if(reply == null){
            response.put("msg","回复不存在");
            return response;
        }
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(user.getRole() == 3 || (user.getId() == reply.getUserId() && user.getRole() == reply.getUserRole())){
            if(reply.getDeleteFlag() == 1){
                response.put("msg","回复已经被删除了，无需重复删除");
                return response;
            }
            replyMapper.deleteByPrimaryKey(replyId);

            Post countPost = new Post();
            countPost.setId(reply.getPostId());
            countPost.setReplyCount(-1);
            postMapper.updateReplyCount(countPost);

            response.put("success",true);
            response.put("msg","成功");
        }else {
            response.put("msg","无权操作！");
        }
        return response;
    }


    @RequestMapping("saveReply")
    @ResponseBody
    public Map<String,Object> reply(HttpSession session, Reply reply){
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(reply.getId() == null){
            reply.setUserId(user.getId());
            reply.setUserName(user.getName());
            reply.setUserRole(user.getRole());
            replyMapper.insertSelective(reply);

            Post countPost = new Post();
            countPost.setId(reply.getPostId());
            countPost.setReplyCount(1);
            postMapper.updateReplyCount(countPost);
        }else {
            replyMapper.updateByPrimaryKeySelective(reply);
        }
        Map<String,Object> response = new HashMap<>();
        response.put("success",true);
        response.put("msg","成功");
        return response;
    }
}
