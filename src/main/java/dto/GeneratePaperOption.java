package dto;

import lombok.Data;

/**
 * [Create]
 * Description: 生成试卷参数
 *
 * @author fengyu.zhang
 * @version 1.0
 */
@Data
public class GeneratePaperOption {
    private boolean autoGenerate;
    private int singleCount;
    private int multiCount;
    private int judgeCount;
}
