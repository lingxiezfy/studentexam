package mapper;

import entity.Message;
import org.apache.ibatis.annotations.Param;
import web.manager.UserCommon;

import java.util.List;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer messageId);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(Integer messageId);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<Message> query(@Param("record") Message record,@Param("user") UserCommon userCommon);
}