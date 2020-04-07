package service;

import entity.Post;

import java.util.List;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/6 21:23 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
public interface CommunityService {

    /**
     * 获取 本周回复排行前 10 的帖子
     */
    List<Post> getWeekHotPost();
}
