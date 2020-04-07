package web;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import dto.community.PageRequest;
import dto.community.ListRequest;
import dto.community.PostWithTopicName;
import dto.community.ReplyWithPostTitle;
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
import web.manager.UserCommon;

import javax.servlet.http.HttpSession;
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

    @RequestMapping("saveReply")
    @ResponseBody
    public Map<String,Object> reply(HttpSession session, Reply reply){
        UserCommon user = (UserCommon) session.getAttribute("userCommon");
        if(reply.getId() == null){
            reply.setUserId(user.getId());
            reply.setUserName(user.getName());
            reply.setUserRole(user.getRole());
            replyMapper.insertSelective(reply);
        }else {
            replyMapper.updateByPrimaryKeySelective(reply);
        }
        Map<String,Object> response = new HashMap<>();
        response.put("success",true);
        response.put("msg","成功");
        return response;
    }
}
