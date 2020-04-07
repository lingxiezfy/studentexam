package dto.community;

import lombok.Data;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/4/5 0:19 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Data
public class ListRequest {
    private Integer pageIndex = 1;
    private Integer pageSize = 8;
    private Integer topic = 0;
    private Integer excellent = 0;
    private String orderBy = "newest"; //hottest
}
