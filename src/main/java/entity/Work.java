package entity;

import java.util.Date;

public class Work {
    private Integer id;

    private String title;

    private String content;

    private Integer timeLimit;

    private Date endTime;

    private Integer fkStatus;

    private Integer fkTeacher;

    private Byte delFlag;
    private Integer exFlag;

    private String exInitSql;

    public Integer getExFlag() {
        return exFlag;
    }

    public void setExFlag(Integer exFlag) {
        this.exFlag = exFlag;
    }

    public String getExInitSql() {
        return exInitSql;
    }

    public void setExInitSql(String exInitSql) {
        this.exInitSql = exInitSql;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(Integer timeLimit) {
        this.timeLimit = timeLimit;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getFkStatus() {
        return fkStatus;
    }

    public void setFkStatus(Integer fkStatus) {
        this.fkStatus = fkStatus;
    }

    public Integer getFkTeacher() {
        return fkTeacher;
    }

    public void setFkTeacher(Integer fkTeacher) {
        this.fkTeacher = fkTeacher;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}