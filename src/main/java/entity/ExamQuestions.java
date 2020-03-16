package entity;

public class ExamQuestions {
    private Integer id;

    private Integer fkExam;

    private Integer fkQuestion;

    private Integer fkQtype;

    private Byte delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFkExam() {
        return fkExam;
    }

    public void setFkExam(Integer fkExam) {
        this.fkExam = fkExam;
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