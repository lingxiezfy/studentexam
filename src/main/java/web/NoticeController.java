package web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * [Create]
 * Description:
 * <br/>Date: 2020/3/28 22:02 - Create
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@RequestMapping("notice")
@Controller
public class NoticeController {

    @RequestMapping("toPublish")
    public String toPublish(){
        return "notice/publish_page";
    }
}
