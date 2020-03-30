package dto.message;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * [Create]
 * Description: 系统通知
 * <br/>Date: 2020/3/8 16:27 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Data
public class SystemNoticeRequest implements Serializable {
    private static final long serialVersionUID = 1L;
    @NotBlank(message = "公告内容不能为空")
    private String content;
}
