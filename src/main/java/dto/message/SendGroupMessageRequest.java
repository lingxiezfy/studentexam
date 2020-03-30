package dto.message;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * [Create]
 * Description:
 * @version 1.0
 */
@Data
public class SendGroupMessageRequest {
    @NotNull(message = "请选择组发送消息")
    private Integer discussionId;
    @NotBlank(message = "操作类型必须")
    private String op;
    @NotBlank(message = "消息不可为空")
    private String message;
}
