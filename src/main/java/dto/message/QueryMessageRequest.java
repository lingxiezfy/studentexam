package dto.message;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/3/8 16:27 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Data
public class QueryMessageRequest implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer pageIndex = 1;
    private Integer pageSize = 10;
    private Integer messageType;
    private Integer messageId;
}
