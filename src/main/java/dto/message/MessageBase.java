package dto.message;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import web.manager.UserCommon;

import java.util.Date;

/**
 * [Create]
 * Description:
 * @version 1.0
 */
@Data
public class MessageBase {
    private String messageType;
    private UserCommon author;
    private  String title;
    private String content;
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date sendTime;

    private long sendMills = System.currentTimeMillis();

    private Integer messageId;
    public MessageBase() {
    }

    public MessageBase(UserCommon author, MessageTypeEnum messageType, String title, String content, Date sendTime) {
        this.author = author;
        this.content = content == null?"":content;
        this.sendTime = sendTime;
        this.title = title == null?"":title;
        this.messageType = messageType.name();
    }

    public MessageBase(UserCommon author, MessageTypeEnum messageType, String title, String content, Date sendTime,Integer messageId) {
        this(author,messageType,title,content,sendTime);
        this.messageId = messageId;
    }
}
