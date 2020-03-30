package dto.message;

/**
 * [Create]
 * Description: 消息类型
 * <br/>Date: 2020/3/8 13:43 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
public enum MessageTypeEnum {
    Default(0,"未定义消息")
    , SystemNotice(1,"系统公告")
    , ClassNotice(2,"班级通知")
    ;

    private int code;
    private String desc;

    MessageTypeEnum(int code, String desc){
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
