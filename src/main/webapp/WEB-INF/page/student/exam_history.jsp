<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/base.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试记录</title>
    <link rel="SHORTCUT ICON" href="${basePath }images/icon.png">
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
        <div class="col-md-12">
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
                                <label class="col-lg-6 control-label">考试时长:</label>
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
		                            <span style="float:right;padding-right:20px">
	                            		<c:forEach items="${answers }" var="answer">
	                            			<c:if test="${answer.fkQtype eq 1 and answer.fkQuestion eq single.id  }">
	                            				<span style="margin-right:20px"><span style="color:#0080FF;font-weight: bold">答案：</span>
		                            				<c:choose>
		                            					<c:when test="${answer.isRight eq true}">
		                            						<span style="color: #00DB00;font-weight: bold">对</span>
		                            					</c:when>
		                            					<c:otherwise>
		                            						<span style="color: red;font-weight: bold">错</span>
		                            					</c:otherwise>
		                            				</c:choose>
	                            				</span>
	                            				<c:if test="${answer.isRight eq false}">
	                            					<span><span style="color:#0080FF;font-weight: bold">错误答案：</span><span style="color: red;font-weight: bold">
	                            						<c:if test="${empty answer.wrongAnswer }">无</c:if>
	                            						<c:if test="${!empty answer.wrongAnswer }">${answer.wrongAnswer }</c:if>
	                            					</span></span>
	                            				</c:if>
	                            			</c:if>
	                            		</c:forEach>
		                            </span>
		                            
		                        </div>
		                        <ul class="question-option">
		                            <li <c:if test="${single.answer == 'A' }">style="color:red;font-weight: bold"</c:if>>
		                               A. <span> ${single.optiona }</span>
		                            </li>
		                            <li <c:if test="${single.answer == 'B' }">style="color:red;font-weight: bold"</c:if>>
		                            	
		                               B. <span> ${single.optionb }</span>
		                            </li>
		                            <li <c:if test="${single.answer == 'C' }">style="color:red;font-weight: bold"</c:if>>
		                               C. <span> ${single.optionc }</span>
		                            </li>
		                            <li <c:if test="${single.answer == 'D' }">style="color:red;font-weight: bold"</c:if>>
		                               D. <span> ${single.optiond }</span>
		                            </li>
		                        </ul>
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
		                            <span style="float:right;padding-right:20px">
	                            		<c:forEach items="${answers }" var="answer">
	                            			<c:if test="${answer.fkQtype eq 2 and answer.fkQuestion eq multi.id  }">
	                            				<span style="margin-right:20px"><span style="color:#0080FF;font-weight: bold">答案：</span>
		                            				<c:choose>
		                            					<c:when test="${answer.isRight eq true}">
		                            						<span style="color: #00DB00;font-weight: bold">对</span>
		                            					</c:when>
		                            					<c:otherwise>
		                            						<span style="color: red;font-weight: bold">错</span>
		                            					</c:otherwise>
		                            				</c:choose>
	                            				</span>
	                            				<c:if test="${answer.isRight eq false}">
	                            					<span><span style="color:#0080FF;font-weight: bold">错误答案：</span><span style="color: red;font-weight: bold">
	                            						<c:if test="${empty answer.wrongAnswer }">无</c:if>
	                            						<c:if test="${!empty answer.wrongAnswer }">${answer.wrongAnswer }</c:if>
	                            					</span></span>
	                            				</c:if>
	                            			</c:if>
	                            		</c:forEach>
		                            </span>
		                        </div>
		                        <ul class="question-option">
		                            <li <c:if test="${fn:contains(multi.answer,'A')}">style="color:red;font-weight: bold"</c:if>>
		                                A. <span> ${multi.optiona }</span>
		                            </li>
		                            <li <c:if test="${fn:contains(multi.answer,'B')}">style="color:red;font-weight: bold"</c:if>>
		                                B. <span> ${multi.optionb }</span>
		                            </li>
		                            <li <c:if test="${fn:contains(multi.answer,'C')}">style="color:red;font-weight: bold"</c:if>>
		                                C. <span> ${multi.optionc }</span>
		                            </li>
		                            <li <c:if test="${fn:contains(multi.answer,'D')}">style="color:red;font-weight: bold"</c:if>>
		                                D. <span> ${multi.optiond }</span>
		                            </li>
		                        </ul>
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
		                        <input type="hidden" name="question-id"/>
		                        <div class="question-title">
		                            <span>${status.count }</span>
		                            <span>. ${judge.title }</span>
		                            <span>(${judge.score }分)</span>
		                            <span style="float:right;padding-right:20px">
	                            		<c:forEach items="${answers }" var="answer">
	                            			<c:if test="${answer.fkQtype eq 3 and answer.fkQuestion eq judge.id  }">
	                            				<span style="margin-right:20px"><span style="color:#0080FF;font-weight: bold">答案：</span>
		                            				<c:choose>
		                            					<c:when test="${answer.isRight eq true}">
		                            						<span style="color: #00DB00;font-weight: bold">对</span>
		                            					</c:when>
		                            					<c:otherwise>
		                            						<span style="color: red;font-weight: bold">错</span>
		                            					</c:otherwise>
		                            				</c:choose>
	                            				</span>
	                            				<c:if test="${answer.isRight eq false}">
	                            					<span>
														<span style="color:#0080FF;font-weight: bold">错误答案：</span>
														<span style="color: red;font-weight: bold">
	                            							<c:if test="${empty answer.wrongAnswer }">无</c:if>
	                            							<c:if test="${!empty answer.wrongAnswer }">
																<c:choose>
																	<c:when test="${answer.wrongAnswer == 1}">
																		错
																	</c:when>
																</c:choose>
															</c:if>
	                            						</span>
													</span>
	                            				</c:if>
	                            			</c:if>
	                            		</c:forEach>
		                            </span>
		                        </div>
		                        <div class="question-answer" id="judge_question_${judge.id }">
		                            <input type="radio" name="judge-${judge.id }" value="0" <c:if test="${judge.answer == 0 }">checked</c:if>/><span <c:if test="${judge.answer == 0 }">style="color:red;font-weight: bold"</c:if>>对</span>
		                            <input type="radio" name="judge-${judge.id }" value="1" <c:if test="${judge.answer == 1 }">checked</c:if>/><span <c:if test="${judge.answer == 1 }">style="color:red;font-weight: bold"</c:if>>错</span>
		                        </div>
	                    	</div>
	                    </c:forEach>
	                </div>
	                <hr/>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${basePath }js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${basePath }js/tips.js"></script>

</body>
</html>