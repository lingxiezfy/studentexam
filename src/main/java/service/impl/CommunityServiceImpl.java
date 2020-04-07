package service.impl;

import entity.Post;
import mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.CommunityService;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/6 21:23 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    PostMapper postMapper;

    /**
     * 获取 本周回复排行前 10 的帖子
     */
    @Override
    public List<Post> getWeekHotPost(){
        Calendar calendar = Calendar.getInstance();
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        calendar.add(Calendar.DAY_OF_MONTH,-(dayOfWeek-1));
        calendar.set(Calendar.HOUR_OF_DAY,0);
        calendar.set(Calendar.MINUTE,0);
        calendar.set(Calendar.SECOND,0);
        calendar.set(Calendar.MILLISECOND,0);
        return postMapper.queryWeekHot(calendar.getTime());
    }
}
