package dto.community;

import entity.Reply;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/8 0:04 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ReplyWithPostTitle extends Reply {

    private String postTitle;
}
