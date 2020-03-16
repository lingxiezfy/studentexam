<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>参加考试</title>

    <link rel="BOOKMARK" href="${basePath }images/icon.png">
    <link rel="stylesheet" type="text/css" href="${basePath }css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/head.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/list_main.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/bootstrap-admin-theme.css">
    <link rel="stylesheet" type="text/css" href="${basePath }css/exam_take.css"/>
    <style>
        .col-center-block {
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        .hasBeenAnswer {
            background: #5d9cec;
            color: #fff;
        }


        .submit {
            background: #FF6347;
            margin-top: 20px;
            border: none;
            display: block;
            width: 80px;
            height: 45px;
            cursor: pointer;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
        }
    </style>

    <script>
        var examId = "${eid}";
    </script>

</head>
<body>
<div class="container">
    <div class="row myCenter">
        <div class="col-md-9">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default bootstrap-admin-no-table-panel">
                        <div class="panel-heading">
                            <div class="text-muted bootstrap-admin-box-title">试卷信息</div>
                        </div>
                        <div class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
                            <div class="col-lg-12 form-group">
                                <label class="col-lg-6 control-label">卷面总分(<span>${exam.totalPoints}</span>)</label>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="col-lg-4 control-label">试卷名:</label>
                                <label class="col-lg-8 control-label"><span>${exam.title}</span></label>
                            </div>
                            <div class="col-lg-4 form-group">
                                <label class="col-lg-6 control-label">考试时间:</label>
                                <label class="col-lg-6 control-label"><span>${exam.timeLimit }分钟</span></label>
                            </div>

                            <div class="col-lg-4 form-group">
                                <label class="col-lg-6 control-label">考生姓名:</label>
                                <label class="col-lg-6 control-label"><span>${user.realname }</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12 col-center-block">
                <!-- 时间限制以及倒计时 -->
                <input type="hidden" id="time-limit" value="${exam.timeLimit}"/>
                <!-- 此试卷的id -->
                <input type="hidden" id="exam-id" value="${exam.id}"/>
                <input type="hidden" id="context-path" value="${basePath }"/>
                <!-- 用来排序题号 -->
                <c:set var="number" value="0"></c:set>
                <hr>
                <c:if test="${!empty singles }">
                	<c:set var="number" value="${number+1 }"></c:set> <!-- number = number+1 -->
	                <div id="single-container">
	                    <!-- 题型标识 -->
	                    <div class="title">
		                    <c:if test="${number eq 1 }">一</c:if>
		                    <c:if test="${number eq 2 }">二</c:if>
		                    <c:if test="${number eq 3 }">三</c:if>
		                                                             、单选题(共<span>${exam.singlePoints}</span>分)
	                    </div>
	                    <c:forEach items="${singles }" var="single" varStatus="status">
	                    	<div class="question">
		                        <!-- 保存题目id -->
		                        <input type="hidden" name="question-id" value="${single.id }" />
		                        <div class="question-title">
		                            <span>${status.count }</span>
		                            <span>. ${single.title}</span>
		                            <span>(${single.score }分)</span>
		                        </div>
		                        <ul class="question-option">
		                            <li>
		                                A. <span> ${single.optiona }</span>
		                            </li>
		                            <li>
		                                B. <span> ${single.optionb }</span>
		                            </li>
		                            <li>
		                                C. <span> ${single.optionc }</span>
		                            </li>
		                            <li>
		                                D. <span> ${single.optiond }</span>
		                            </li>
		                        </ul>
		                        <div class="question-answer" id="single_question_${single.id }" >
		                           	 答案:
		                            <input type="radio" name="single-${single.id }" value="A"/>A
		                            <input type="radio" name="single-${single.id }" value="B"/>B
		                            <input type="radio" name="single-${single.id }" value="C"/>C
		                            <input type="radio" name="single-${single.id }" value="D"/>D
		                        </div>
	                    	</div>
	                    </c:forEach>
	                </div>
	                <hr>
                </c:if>
                
                <!-- 多选题 -->
                <c:if test="${!empty multis }">
                	<c:set var="number" value="${number+1 }"></c:set>
	                <div id="multi-container">
	                    <div class="title">
	                    	<c:if test="${number eq 1 }">一</c:if>
		                    <c:if test="${number eq 2 }">二</c:if>
		                    <c:if test="${number eq 3 }">三</c:if>
	                                                                       、多选题　(共<span>${exam.multiPoints}</span>分)
	                    </div>
	                    <c:forEach items="${multis }" var="multi" varStatus="status">
	                    	<div class="question">
		                        <input type="hidden" name="question-id" value="${multi.id }"/>
		                        <div class="question-title">
		                            <span>${status.count }</span>
		                            <span>. ${multi.title }</span>
		                            <span>(${multi.score }分)</span>
		                        </div>
		                        <ul class="question-option">
		                            <li>
		                                A. <span> ${multi.optiona }</span>
		                            </li>
		                            <li>
		                                B. <span> ${multi.optionb }</span>
		                            </li>
		                            <li>
		                                C. <span> ${multi.optionc }</span>
		                            </li>
		                            <li>
		                                D. <span> ${multi.optiond }</span>
		                            </li>
		                        </ul>
		                        <div class="question-answer" id="multi_question_${multi.id }">
		                          	 答案:
		                            <input type="checkbox" name="multi-${multi.id }" value="A"/>A
		                            <input type="checkbox" name="multi-${multi.id }" value="B"/>B
		                            <input type="checkbox" name="multi-${multi.id }" value="C"/>C
		                            <input type="checkbox" name="multi-${multi.id }" value="D"/>D
		                        </div>
	                    	</div>
	                    </c:forEach>
	                </div>
	                <hr>
                </c:if>
                
                <!-- 判断题 -->
                <c:if test="${!empty judges }">
                	<c:set var="number" value="${number+1 }"></c:set>
	                <div id="judge-container">
	                    <div class="title">
	                    	<c:if test="${number eq 1 }">一</c:if>
		                    <c:if test="${number eq 2 }">二</c:if>
		                    <c:if test="${number eq 3 }">三</c:if>
	                                                                         、判断题　(共<span>${exam.judgePoints}</span>分)
	                    </div>
	                    <c:forEach items="${judges }" var="judge" varStatus="status">
	                    	<div class="question">
		                        <input type="hidden" name="question-id" value="${judge.id}"/>
		                        <div class="question-title">
		                            <span>${status.count }</span>
		                            <span>. ${judge.title }</span>
		                            <span>(${judge.score }分)</span>
		                        </div>
		                        <div class="question-answer" id="judge_question_${judge.id }">
		                            <input type="radio" name="judge-${judge.id }" value="0"/>正确
		                            <input type="radio" name="judge-${judge.id }" value="1"/>错误
		                        </div>
	                    	</div>
	                    </c:forEach>
	                </div>
	                <hr/>
                </c:if>
            </div>
        </div>

        <div class="col-md-3 nr_right">
            <div class="nr_rt_main">
                <div class="rt_nr1">
                    <div class="rt_nr1_title">
                        <h1>答题卡</h1>
                        <p class="test_time">
                            <b class="alt-1" id="count-time" ></b>
                        </p>
                    </div>
                    <c:if test="${!empty singles }">
	                    <div class="rt_content">
	                        <div class="rt_content_tt">
	                            <h2>单选题</h2>
	                            <p>
	                                <span>共</span>
	                                <span>${fn:length(singles)}</span> 题
	                            </p>
	                        </div>
	                        <div class="rt_content_nr answerSheet">
	                            <ul>
	                            	<c:forEach items="${singles }" var="single" varStatus="status">
		                                <li>
		                                    <a href="#single_question_${single.id }">${status.count }</a>
		                                </li>
	                                </c:forEach>
	                            </ul>
	                        </div>
	                    </div>
                    </c:if>
                    <c:if test="${!empty multis }">
	                    <div class="rt_content">
	                        <div class="rt_content_tt">
	                            <h2>多选题</h2>
	                            <p>
	                                <span>共</span>
	                                <span>${fn:length(multis)}</span> 题
	                            </p>
	                        </div>
	                        <div class="rt_content_nr answerSheet">
	                            <ul>
	                            	<c:forEach items="${multis }" var="multi" varStatus="status">
		                                <li>
		                                    <a href="#multi_question_${multi.id }">${status.count }</a>
		                                </li>
	                                </c:forEach>
	                            </ul>
	                        </div>
	                    </div>
                    </c:if>
                    <c:if test="${!empty judges }">
	                    <div class="rt_content">
	                        <div class="rt_content_tt">
	                            <h2>判断题</h2>
	                            <p>
	                                <span>共</span>
	                                <span>${fn:length(judges)}</span> 题
	                            </p>
	                        </div>
	                        <div class="rt_content_nr answerSheet">
	                            <ul>
	                            	<c:forEach items="${judges }" var="judge" varStatus="status">
		                                <li>
		                                    <a href="#judge_question_${judge.id }">${status.count }</a>
		                                </li>
	                                </c:forEach>
	                            </ul>
	                        </div>
	                    </div>
					</c:if>
                    <div>
                        <div style="text-align: center;margin-bottom: 20px;">
                            <button class="submit" id="submit-btn">提交</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>

<script type="text/javascript" src="${basePath }js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/base.js"></script>
<script type="text/javascript" src="${basePath }js/tips.js"></script>
<script type="text/javascript" src="${basePath }js/exam_take.js"></script>

<script>
    $(function () {
        $('.question-answer input').click(function () {
            // debugger;
            var examId = $(this).closest('.question-answer').attr('id'); // 得到题目ID
            var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡
            // 设置已答题
            if (!cardLi.hasClass('hasBeenAnswer')) {
                cardLi.addClass('hasBeenAnswer');
            }
        });
    });

</script>

</body>
</html>