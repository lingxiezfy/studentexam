package entity;

public class ExamResultQuestion {
    private Integer id;

    private Boolean isRight;

    private String wrongAnswer;

    private Integer fkExamResult;

    private Integer fkQuestion;

    private Integer fkQtype;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getIsRight() {
        return isRight;
    }

    public void setIsRight(Boolean isRight) {
        this.isRight = isRight;
    }

    public String getWrongAnswer() {
        return wrongAnswer;
    }

    public void setWrongAnswer(String wrongAnswer) {
        this.wrongAnswer = wrongAnswer == null ? null : wrongAnswer.trim();
    }

    public Integer getFkExamResult() {
        return fkExamResult;
    }

    public void setFkExamResult(Integer fkExamResult) {
        this.fkExamResult = fkExamResult;
    }

    public Integer getFkQuestion() {
        return fkQuestion;
    }

    public void setFkQuestion(Integer fkQuestion) {
        this.fkQuestion = fkQuestion;
    }

    public Integer getFkQtype() {
        return fkQtype;
    }

    public void setFkQtype(Integer fkQtype) {
        this.fkQtype = fkQtype;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }
}