package entity;

public class QuestionSingle {
    private Integer id;

    private String title;

    private String optiona;

    private String optionb;

    private String optionc;

    private String optiond;

    private String answer;

    private Double score;

    private Integer fkTeacher;

    private Integer fkQtype;

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

    public String getOptiona() {
        return optiona;
    }

    public void setOptiona(String optiona) {
        this.optiona = optiona == null ? null : optiona.trim();
    }

    public String getOptionb() {
        return optionb;
    }

    public void setOptionb(String optionb) {
        this.optionb = optionb == null ? null : optionb.trim();
    }

    public String getOptionc() {
        return optionc;
    }

    public void setOptionc(String optionc) {
        this.optionc = optionc == null ? null : optionc.trim();
    }

    public String getOptiond() {
        return optiond;
    }

    public void setOptiond(String optiond) {
        this.optiond = optiond == null ? null : optiond.trim();
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public Integer getFkTeacher() {
        return fkTeacher;
    }

    public void setFkTeacher(Integer fkTeacher) {
        this.fkTeacher = fkTeacher;
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