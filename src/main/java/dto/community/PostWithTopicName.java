package dto.community;

import entity.Post;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/6 20:54 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class PostWithTopicName extends Post {
    private String topicName;
}
