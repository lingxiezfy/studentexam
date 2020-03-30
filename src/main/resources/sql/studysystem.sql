/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50520
 Source Host           : localhost:3306
 Source Schema         : studysystem

 Target Server Type    : MySQL
 Target Server Version : 50520
 File Encoding         : 65001

 Date: 14/03/2020 20:41:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clazz
-- ----------------------------
DROP TABLE IF EXISTS `clazz`;
CREATE TABLE `clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `cno` int(11) DEFAULT NULL COMMENT '班级编号（班号）',
  `fk_grade` int(11) DEFAULT NULL COMMENT '年级ID（外键）',
  `fk_major` int(11) DEFAULT NULL COMMENT '专业ID（外键）',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_clazz_grade`(`fk_grade`) USING BTREE,
  INDEX `exam_clazz_major`(`fk_major`) USING BTREE,
  CONSTRAINT `exam_clazz_grade` FOREIGN KEY (`fk_grade`) REFERENCES `grade` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `exam_clazz_major` FOREIGN KEY (`fk_major`) REFERENCES `major` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '班级信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of clazz
-- ----------------------------
INSERT INTO `clazz` VALUES (1, 1, 5, 1, 0);
INSERT INTO `clazz` VALUES (2, 2, 5, 1, 1);
INSERT INTO `clazz` VALUES (3, 201601, 3, 1, 0);
INSERT INTO `clazz` VALUES (4, 201701, 3, 3, 0);

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '试卷标题',
  `time_limit` int(11) DEFAULT NULL COMMENT '考试时限（分钟）',
  `end_time` date DEFAULT NULL COMMENT '考试截止时间（根据运行时间计算）',
  `fk_status` int(11) DEFAULT NULL COMMENT '试卷运行状态（外键）',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '出卷老师（外键）',
  `single_points` double DEFAULT NULL COMMENT '单选题得分',
  `multi_points` double DEFAULT NULL COMMENT '多选题得分',
  `judge_points` double DEFAULT NULL COMMENT '判断题得分',
  `total_points` double DEFAULT NULL COMMENT '总得分',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_exam_techaer`(`fk_teacher`) USING BTREE,
  INDEX `exam_exam_exam_status`(`fk_status`) USING BTREE,
  CONSTRAINT `exam_exam_exam_status` FOREIGN KEY (`fk_status`) REFERENCES `exam_status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `exam_exam_techaer` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (1, 'java基础', 60, '2020-03-13', 3, 1, 5, 10, 5, 20, 0);
INSERT INTO `exam` VALUES (2, 'java web', 100, '2020-03-12', 2, 1, 5, 10, 5, 20, 0);
INSERT INTO `exam` VALUES (3, 'java基础01', 80, '2020-02-23', 2, 1, 5, 0, 5, 10, 0);
INSERT INTO `exam` VALUES (4, 'java基础考试', 80, '2019-09-26', 3, 1, 5, 10, 0, 15, 0);
INSERT INTO `exam` VALUES (5, 'java', 80, '2019-09-27', 3, 1, 5, 10, 0, 15, 0);
INSERT INTO `exam` VALUES (6, '高数', 120, NULL, 1, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `exam` VALUES (7, '课堂', 20, NULL, 2, 3, 5, 0, 0, 5, 0);

-- ----------------------------
-- Table structure for exam_clazz
-- ----------------------------
DROP TABLE IF EXISTS `exam_clazz`;
CREATE TABLE `exam_clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fk_exam` int(11) DEFAULT NULL COMMENT '试卷ID（外键）',
  `fk_clazz` int(11) DEFAULT NULL COMMENT '关联班级ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_clazz_exam`(`fk_exam`) USING BTREE,
  INDEX `exam_clazz_clazz`(`fk_clazz`) USING BTREE,
  CONSTRAINT `exam_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `exam_clazz_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam_clazz
-- ----------------------------
INSERT INTO `exam_clazz` VALUES (1, 1, 3, 0);
INSERT INTO `exam_clazz` VALUES (2, 2, 3, 0);
INSERT INTO `exam_clazz` VALUES (3, 2, 1, 0);
INSERT INTO `exam_clazz` VALUES (4, 3, 3, 1);
INSERT INTO `exam_clazz` VALUES (5, 4, 3, 0);
INSERT INTO `exam_clazz` VALUES (6, 5, 3, 0);
INSERT INTO `exam_clazz` VALUES (7, 1, 4, 1);
INSERT INTO `exam_clazz` VALUES (8, 1, 1, 1);
INSERT INTO `exam_clazz` VALUES (9, 7, 4, 0);

-- ----------------------------
-- Table structure for exam_questions
-- ----------------------------
DROP TABLE IF EXISTS `exam_questions`;
CREATE TABLE `exam_questions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fk_exam` int(11) DEFAULT NULL COMMENT '关联试卷ID（外键）',
  `fk_question` int(11) DEFAULT NULL COMMENT '题目ID（外键）',
  `fk_qtype` int(11) DEFAULT NULL COMMENT '题目类型ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_exam_questions_exam`(`fk_exam`) USING BTREE,
  CONSTRAINT `exam_exam_questions_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷题目表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam_questions
-- ----------------------------
INSERT INTO `exam_questions` VALUES (1, 1, 1, 1, 0);
INSERT INTO `exam_questions` VALUES (2, 1, 1, 2, 0);
INSERT INTO `exam_questions` VALUES (3, 1, 1, 3, 0);
INSERT INTO `exam_questions` VALUES (4, 2, 1, 1, 0);
INSERT INTO `exam_questions` VALUES (5, 2, 1, 3, 0);
INSERT INTO `exam_questions` VALUES (6, 2, 1, 2, 0);
INSERT INTO `exam_questions` VALUES (7, 3, 1, 1, 0);
INSERT INTO `exam_questions` VALUES (8, 3, 1, 3, 0);
INSERT INTO `exam_questions` VALUES (9, 4, 1, 1, 0);
INSERT INTO `exam_questions` VALUES (10, 4, 1, 2, 0);
INSERT INTO `exam_questions` VALUES (11, 5, 1, 1, 0);
INSERT INTO `exam_questions` VALUES (12, 5, 1, 2, 0);
INSERT INTO `exam_questions` VALUES (13, 7, 1, 1, 0);

-- ----------------------------
-- Table structure for exam_result
-- ----------------------------
DROP TABLE IF EXISTS `exam_result`;
CREATE TABLE `exam_result`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `point` double(11, 1) DEFAULT NULL COMMENT '得分',
  `time` date DEFAULT NULL COMMENT '考试日期',
  `exam_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '试卷标题',
  `fk_exam` int(11) DEFAULT NULL COMMENT '关联试卷ID（外键）',
  `fk_student` int(11) DEFAULT NULL COMMENT '关联学生ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_result_exam`(`fk_exam`) USING BTREE,
  INDEX `exam_result_student`(`fk_student`) USING BTREE,
  CONSTRAINT `exam_result_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `exam_result_student` FOREIGN KEY (`fk_student`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '考试结果表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam_result
-- ----------------------------
INSERT INTO `exam_result` VALUES (1, 20.0, '2019-09-24', 'java基础', 1, 4, 0);
INSERT INTO `exam_result` VALUES (2, 20.0, '2019-09-25', 'java基础', 1, 5, 0);
INSERT INTO `exam_result` VALUES (3, 10.0, '2019-09-25', 'java基础01', 3, 5, 0);
INSERT INTO `exam_result` VALUES (4, 5.0, '2019-09-25', 'java基础考试', 4, 5, 0);
INSERT INTO `exam_result` VALUES (5, 5.0, '2019-09-26', 'java', 5, 5, 0);

-- ----------------------------
-- Table structure for exam_result_question
-- ----------------------------
DROP TABLE IF EXISTS `exam_result_question`;
CREATE TABLE `exam_result_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `is_right` bit(1) DEFAULT NULL COMMENT '是否正确（0正确，1错误）',
  `wrong_answer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '错误答案',
  `fk_exam_result` int(11) DEFAULT NULL COMMENT '关联试卷结果ID（外键）',
  `fk_question` int(11) DEFAULT NULL COMMENT '关联题目ID（非外键）',
  `fk_qtype` int(11) DEFAULT NULL COMMENT '题目类型ID（非外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_result_question_exam_result`(`fk_exam_result`) USING BTREE,
  CONSTRAINT `exam_result_question_exam_result` FOREIGN KEY (`fk_exam_result`) REFERENCES `exam_result` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam_result_question
-- ----------------------------
INSERT INTO `exam_result_question` VALUES (1, b'1', NULL, 1, 1, 1, 0);
INSERT INTO `exam_result_question` VALUES (2, b'1', NULL, 1, 1, 2, 0);
INSERT INTO `exam_result_question` VALUES (3, b'1', NULL, 1, 1, 3, 0);
INSERT INTO `exam_result_question` VALUES (4, b'1', NULL, 2, 1, 1, 0);
INSERT INTO `exam_result_question` VALUES (5, b'1', NULL, 2, 1, 2, 0);
INSERT INTO `exam_result_question` VALUES (6, b'1', NULL, 2, 1, 3, 0);
INSERT INTO `exam_result_question` VALUES (7, b'1', NULL, 3, 1, 1, 0);
INSERT INTO `exam_result_question` VALUES (8, b'1', NULL, 3, 1, 3, 0);
INSERT INTO `exam_result_question` VALUES (9, b'1', NULL, 4, 1, 1, 0);
INSERT INTO `exam_result_question` VALUES (10, b'0', 'A', 4, 1, 2, 0);
INSERT INTO `exam_result_question` VALUES (11, b'1', NULL, 5, 1, 1, 0);
INSERT INTO `exam_result_question` VALUES (12, b'0', 'A', 5, 1, 2, 0);

-- ----------------------------
-- Table structure for exam_status
-- ----------------------------
DROP TABLE IF EXISTS `exam_status`;
CREATE TABLE `exam_status`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷状态表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of exam_status
-- ----------------------------
INSERT INTO `exam_status` VALUES (1, '未初始化');
INSERT INTO `exam_status` VALUES (2, '未运行');
INSERT INTO `exam_status` VALUES (3, '运行中');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '年级名称',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '年级信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (1, '2018', 0);
INSERT INTO `grade` VALUES (2, '2017', 0);
INSERT INTO `grade` VALUES (3, '2016', 0);
INSERT INTO `grade` VALUES (4, '2015', 0);
INSERT INTO `grade` VALUES (5, '2019', 0);
INSERT INTO `grade` VALUES (6, '2014', 0);

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '专业名称',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '专业信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (1, '计算机科学与技术', 0);
INSERT INTO `major` VALUES (2, '测试', 1);
INSERT INTO `major` VALUES (3, '土木工程', 0);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `modified` tinyint(4) DEFAULT 0 COMMENT '是否改过密码 0没改过  1改过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (2, 'admin', '96E79218965EB72C92A549DD5A330112', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '访问路径',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `pid` int(9) DEFAULT NULL COMMENT '父节点ID',
  `topid` int(9) DEFAULT NULL COMMENT '顶级节点ID',
  `menu_level` int(1) DEFAULT NULL COMMENT '菜单级别',
  `sort` int(5) DEFAULT NULL COMMENT '排序',
  `hidden` int(1) DEFAULT NULL COMMENT '是否隐藏（0显示，1隐藏）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '主页', 'adminManager/toIndex', 'fa-home', NULL, NULL, 1, 1, 0);
INSERT INTO `menu` VALUES (2, '年级管理', 'adminManager/grade', 'fa-building', NULL, NULL, 1, 2, 0);
INSERT INTO `menu` VALUES (3, '专业管理', 'adminManager/major', 'fa-graduation-cap', NULL, NULL, 1, 3, 0);
INSERT INTO `menu` VALUES (4, '班级管理', 'adminManager/clazz', 'fa-cube', NULL, NULL, 1, 4, 0);
INSERT INTO `menu` VALUES (5, '学生管理', 'adminManager/stuList', 'fa-users', NULL, NULL, 1, 5, 0);
INSERT INTO `menu` VALUES (6, '教师管理', 'adminManager/teaList', 'fa-user', NULL, NULL, 1, 6, 0);
INSERT INTO `menu` VALUES (7, '试卷管理', 'teacher/examPaper', 'fa-file-text-o', NULL, NULL, 1, 7, 0);
INSERT INTO `menu` VALUES (8, '单选题', 'teacher/single', 'fa-check-square-o', NULL, NULL, 1, 8, 0);
INSERT INTO `menu` VALUES (9, '多选题', 'teacher/multi', 'fa-bolt ', NULL, NULL, 1, 9, 0);
INSERT INTO `menu` VALUES (10, '判断题', 'teacher/judge', 'fa-gavel', NULL, NULL, 1, 10, 0);
INSERT INTO `menu` VALUES (11, '参加考试', 'student/examList', 'fa-pencil-square-o ', NULL, NULL, 1, 11, 0);
INSERT INTO `menu` VALUES (12, '考试记录', 'student/examHistory', 'fa-file-word-o', NULL, NULL, 1, 12, 0);
INSERT INTO `menu` VALUES (13, '教师主页', 'teacher/toIndex', 'fa-home', NULL, NULL, 1, 13, 0);
INSERT INTO `menu` VALUES (14, '学生主页', 'student/toIndex', 'fa-home', NULL, NULL, 1, 14, 0);
INSERT INTO `menu` VALUES (15, '课堂随练', 'teacher/workPaper', 'fa-grav ', NULL, NULL, 1, 15, 0);
INSERT INTO `menu` VALUES (16, '作业提交', 'student/workSubmit', 'fa-keyboard-o', NULL, NULL, 1, 16, 0);
INSERT INTO `menu` VALUES (17, '作业统计', 'teacher/workCount', 'fa-keyboard-o', NULL, NULL, 1, 17, 0);
INSERT INTO `menu` VALUES (18, '课堂资源', 'teacher/uploadResource', 'fa-keyboard-o', NULL, NULL, 1, 18, 0);
INSERT INTO `menu` VALUES (19, '下载资源', 'student/downloadResource', 'fa-keyboard-o', NULL, NULL, 1, 19, 0);

-- ----------------------------
-- Table structure for question_judge
-- ----------------------------
DROP TABLE IF EXISTS `question_judge`;
CREATE TABLE `question_judge`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目',
  `answer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '答案',
  `score` double(11, 1) DEFAULT NULL COMMENT '分值',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '出题老师ID（非外键）',
  `fk_qtype` int(11) DEFAULT NULL COMMENT '试卷类型ID（非外键）',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_judge_qtype`(`fk_qtype`) USING BTREE,
  INDEX `question_judge_teacher`(`fk_teacher`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '判断题信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of question_judge
-- ----------------------------
INSERT INTO `question_judge` VALUES (1, 'java判断题', '0', 5.0, 1, 3, 0);

-- ----------------------------
-- Table structure for question_multi
-- ----------------------------
DROP TABLE IF EXISTS `question_multi`;
CREATE TABLE `question_multi`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目',
  `optionA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项A',
  `optionB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选择B',
  `optionC` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项C',
  `optionD` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项D',
  `answer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '答案',
  `score` double(11, 1) DEFAULT NULL COMMENT '分值',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '出题老师ID（非外键）',
  `fk_qtype` int(11) DEFAULT NULL COMMENT '试卷类型ID（非外键）',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_multi_teacher`(`fk_teacher`) USING BTREE,
  INDEX `question_multi_qtype`(`fk_qtype`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '多选题信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of question_multi
-- ----------------------------
INSERT INTO `question_multi` VALUES (1, 'java多选题', 'A', 'B', 'C', 'D', 'A,B', 10.0, 1, 2, 0);

-- ----------------------------
-- Table structure for question_single
-- ----------------------------
DROP TABLE IF EXISTS `question_single`;
CREATE TABLE `question_single`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '题目',
  `optionA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项A',
  `optionB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选择B',
  `optionC` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项C',
  `optionD` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选项D',
  `answer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '答案',
  `score` double(11, 1) DEFAULT NULL COMMENT '分值',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '出题老师ID（非外键）',
  `fk_qtype` int(11) DEFAULT NULL COMMENT '试卷类型ID（非外键）',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `question_single_teacher`(`fk_teacher`) USING BTREE,
  INDEX `question_single_qtype`(`fk_qtype`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '单选题表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of question_single
-- ----------------------------
INSERT INTO `question_single` VALUES (1, 'java单选题', 'A', 'B', 'C', 'D', 'A', 5.0, 3, 1, 0);
INSERT INTO `question_single` VALUES (2, 'haha', 'a', 'b', 'c', 'd', 'A', 10.0, 3, 1, 0);
INSERT INTO `question_single` VALUES (3, 'fdhs', 'a', 'b', 'c', 'd', 'C', 5.0, 3, 1, 0);
INSERT INTO `question_single` VALUES (4, 'gfdda', 'a', 'vb', 'd', 'g', 'D', 2.0, 3, 1, 0);

-- ----------------------------
-- Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '试卷类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷类型表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of question_type
-- ----------------------------
INSERT INTO `question_type` VALUES (1, '单选题');
INSERT INTO `question_type` VALUES (2, '多选题');
INSERT INTO `question_type` VALUES (3, '判断题');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '学生');
INSERT INTO `role` VALUES (2, '教师');
INSERT INTO `role` VALUES (3, '管理员');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1, 11);
INSERT INTO `role_menu` VALUES (2, 1, 12);
INSERT INTO `role_menu` VALUES (3, 2, 7);
INSERT INTO `role_menu` VALUES (4, 2, 8);
INSERT INTO `role_menu` VALUES (5, 2, 9);
INSERT INTO `role_menu` VALUES (6, 2, 10);
INSERT INTO `role_menu` VALUES (7, 3, 1);
INSERT INTO `role_menu` VALUES (8, 3, 2);
INSERT INTO `role_menu` VALUES (9, 3, 3);
INSERT INTO `role_menu` VALUES (10, 3, 4);
INSERT INTO `role_menu` VALUES (11, 3, 5);
INSERT INTO `role_menu` VALUES (12, 3, 6);
INSERT INTO `role_menu` VALUES (13, 2, 15);
INSERT INTO `role_menu` VALUES (14, 1, 16);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `realname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '真实姓名',
  `fk_clazz` int(11) DEFAULT NULL COMMENT '关联的班级ID（外键）',
  `modified` tinyint(4) DEFAULT 0 COMMENT '是否修改过密码（0没改，1改过）',
  `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除)默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_stu_clazz`(`fk_clazz`) USING BTREE,
  CONSTRAINT `exam_stu_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 's1', '96E79218965EB72C92A549DD5A330112', NULL, NULL, 0, NULL);
INSERT INTO `student` VALUES (2, 'txw', '96E79218965EB72C92A549DD5A330112', '', NULL, 0, NULL);
INSERT INTO `student` VALUES (3, 'dy', '96E79218965EB72C92A549DD5A330112', 'demo', 4, 0, 0);
INSERT INTO `student` VALUES (4, 'ztx', '96E79218965EB72C92A549DD5A330112', '赵天星', 3, 0, 0);
INSERT INTO `student` VALUES (5, 'hahaha', '96E79218965EB72C92A549DD5A330112', 'demo', 3, 0, 0);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `realname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '真实姓名',
  `modified` tinyint(4) DEFAULT 0 COMMENT '是否改过密码（0没改，1改过）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除(0未删除，1删除)默认0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, 't1', '21232F297A57A5A743894A0E4A801FC3', 'demo', 0, 0);
INSERT INTO `teacher` VALUES (2, 'ztx', '96E79218965EB72C92A549DD5A330112', '赵天星', 0, 0);
INSERT INTO `teacher` VALUES (3, 'dy', '96E79218965EB72C92A549DD5A330112', 'demo', 1, 0);
INSERT INTO `teacher` VALUES (4, 'demo', '96E79218965EB72C92A549DD5A330112', 'demo', 0, 0);

-- ----------------------------
-- Table structure for teacher_clazz
-- ----------------------------
DROP TABLE IF EXISTS `teacher_clazz`;
CREATE TABLE `teacher_clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '教师ID（外键）',
  `fk_clazz` int(11) DEFAULT NULL COMMENT '班级ID（外键）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_teacher_clazz_teacher`(`fk_teacher`) USING BTREE,
  INDEX `exam_teacher_clazz_clazz`(`fk_clazz`) USING BTREE,
  CONSTRAINT `exam_teacher_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `exam_teacher_clazz_teacher` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师班级关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of teacher_clazz
-- ----------------------------
INSERT INTO `teacher_clazz` VALUES (1, 3, 4);

-- ----------------------------
-- Table structure for work
-- ----------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作业标题',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作业备注',
  `time_limit` int(11) DEFAULT NULL COMMENT '作业时限（分钟）',
  `end_time` date DEFAULT NULL COMMENT '作业提交截止时间（根据运行时间计算）',
  `fk_status` int(11) DEFAULT NULL COMMENT '作业运行状态（外键）',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '出题老师（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_work_techaer`(`fk_teacher`) USING BTREE,
  INDEX `work_work_work_status`(`fk_status`) USING BTREE,
  CONSTRAINT `work_work_techaer` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `work_work_work_status` FOREIGN KEY (`fk_status`) REFERENCES `work_status` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '作业信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of work
-- ----------------------------
INSERT INTO `work` VALUES (1, '课堂随练', '1.进程与线程的区别？\r\n2.为什么要用多线程？\r\n3.多线程创建方式？\r\n4.是继承Thread类好还是实现Runnable接口好？', 30, '2020-03-27', 3, 3, 0);
INSERT INTO `work` VALUES (7, '课堂练习02,你们加油！', NULL, 10, NULL, 1, 3, 1);
INSERT INTO `work` VALUES (8, '课堂练习03', '1.理解线程安全？\r\n2.synchronized用法?\r\n3.死锁?', 20, '2020-02-23', 2, 3, 0);
INSERT INTO `work` VALUES (9, '科比', 'fsa', 2, NULL, 1, 3, 1);
INSERT INTO `work` VALUES (10, '课堂练习02', '1.多线程之间如何通讯\r\n2.wait、notify、notifyAll()方法\r\n3.lock\r\n4.停止线程\r\n5.守护线程\r\n6.Join方法\r\n7.优先级\r\n8.Yield', 20, NULL, 1, 3, 0);
INSERT INTO `work` VALUES (11, '课堂练习01', '加油', 30, '2020-02-23', 2, 3, 1);

-- ----------------------------
-- Table structure for work_clazz
-- ----------------------------
DROP TABLE IF EXISTS `work_clazz`;
CREATE TABLE `work_clazz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fk_work` int(11) DEFAULT NULL COMMENT '作业ID（外键）',
  `fk_clazz` int(11) DEFAULT NULL COMMENT '关联班级ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_clazz_work`(`fk_work`) USING BTREE,
  INDEX `work_clazz_clazz`(`fk_clazz`) USING BTREE,
  CONSTRAINT `work_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `work_clazz_work` FOREIGN KEY (`fk_work`) REFERENCES `work` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of work_clazz
-- ----------------------------
INSERT INTO `work_clazz` VALUES (1, 1, 1, 0);
INSERT INTO `work_clazz` VALUES (9, 1, 4, 0);
INSERT INTO `work_clazz` VALUES (10, 8, 4, 0);
INSERT INTO `work_clazz` VALUES (11, 11, 4, 0);
INSERT INTO `work_clazz` VALUES (12, 1, 3, 0);

-- ----------------------------
-- Table structure for work_correcting
-- ----------------------------
DROP TABLE IF EXISTS `work_correcting`;
CREATE TABLE `work_correcting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `corTime` date DEFAULT NULL COMMENT '作业批改日期',
  `point` double(11, 1) DEFAULT NULL COMMENT '得分',
  `fk_submit` int(11) DEFAULT NULL COMMENT '关联提交作业ID（外键）',
  `fk_teacher` int(11) DEFAULT NULL COMMENT '关联老师ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_result_submit`(`fk_submit`) USING BTREE,
  INDEX `work_result_teacher`(`fk_teacher`) USING BTREE,
  CONSTRAINT `work_result_submit` FOREIGN KEY (`fk_submit`) REFERENCES `work_submit` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `work_result_teacher` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师批改作业结果表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for work_status
-- ----------------------------
DROP TABLE IF EXISTS `work_status`;
CREATE TABLE `work_status`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '作业状态表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of work_status
-- ----------------------------
INSERT INTO `work_status` VALUES (1, '未初始化');
INSERT INTO `work_status` VALUES (2, '未运行');
INSERT INTO `work_status` VALUES (3, '运行中');

-- ----------------------------
-- Table structure for work_submit
-- ----------------------------
DROP TABLE IF EXISTS `work_submit`;
CREATE TABLE `work_submit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `subTime` date DEFAULT NULL COMMENT '作业提交日期',
  `work_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作业标题',
  `fileUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件提交路径',
  `fk_work` int(11) DEFAULT NULL COMMENT '关联作业ID（外键）',
  `fk_student` int(11) DEFAULT NULL COMMENT '关联学生ID（外键）',
  `del_flag` tinyint(4) DEFAULT 0 COMMENT '是否删除（0未删除 1删除）默认0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `work_result_work`(`fk_work`) USING BTREE,
  INDEX `work_result_student`(`fk_student`) USING BTREE,
  CONSTRAINT `work_result_student` FOREIGN KEY (`fk_student`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `work_result_work` FOREIGN KEY (`fk_work`) REFERENCES `work` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生作业提交结果表' ROW_FORMAT = Compact;


-- ----------------------------
-- Table structure for message 消息流水表
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
                           `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
                           `from_role` int(11) DEFAULT 0 not null COMMENT '发送用户角色',
                           `from_id` int(11) DEFAULT 0 not null COMMENT '发送用户id',
                           `to_role` int(11) DEFAULT 0 not NULL COMMENT '接收用户角色',
                           `to_id` int(11) DEFAULT 0 not NULL COMMENT '接收用户id',
                           `message_content` varchar(500) default '' NOT NULL COMMENT '消息内容',
                           `message_type` int(11) DEFAULT 0 not null COMMENT '消息类型(1:系统公告,2:班级通知)',
                           `origin_source` int(11) DEFAULT 0 not NULL COMMENT '来源Id(消息类型1:0，2:班级_老师的关联Id)',
                           read_state int(11) default 0 not null comment '是否已读（0：未读，1：已读）',
                           create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
                           update_time datetime default CURRENT_TIMESTAMP not null comment '更新时间',
                           PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT = '消息流水表';


SET FOREIGN_KEY_CHECKS = 1;
