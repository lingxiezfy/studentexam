package mapper;

import dto.community.PostWithTopicName;
import entity.Post;
import entity.Reply;

import java.util.Date;
import java.util.List;

public interface PostMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Post record);

    int insertSelective(Post record);

    Post selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Post record);

    int updateByPrimaryKeyWithBLOBs(Post record);

    int updateByPrimaryKey(Post record);

    List<PostWithTopicName> query(Post record);

    List<Post> queryWeekHot(Date weekStart);

    int updateReplyCount(Post record);
}