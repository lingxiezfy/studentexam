package entity;

import java.util.Date;

public class Exam {
    private Integer id;

    private String title;

    private Integer timeLimit;

    private Date endTime;

    private Integer fkStatus;

    private Integer fkTeacher;

    private Double singlePoints;

    private Double multiPoints;

    private Double judgePoints;

    private Double totalPoints;

    private Byte delFlag;

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

    public Double getSinglePoints() {
        return singlePoints;
    }

    public void setSinglePoints(Double singlePoints) {
        this.singlePoints = singlePoints;
    }

    public Double getMultiPoints() {
        return multiPoints;
    }

    public void setMultiPoints(Double multiPoints) {
        this.multiPoints = multiPoints;
    }

    public Double getJudgePoints() {
        return judgePoints;
    }

    public void setJudgePoints(Double judgePoints) {
        this.judgePoints = judgePoints;
    }

    public Double getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(Double totalPoints) {
        this.totalPoints = totalPoints;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}