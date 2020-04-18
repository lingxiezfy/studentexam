drop table if exists exam_clazz;

drop table if exists exam_questions;

drop table if exists exam_result_question;

drop table if exists exam_result;

drop table if exists exam;

drop table if exists exam_status;

drop table if exists manager;

drop table if exists menu;

drop table if exists message;

drop table if exists post;

drop table if exists question_judge;

drop table if exists question_multi;

drop table if exists question_single;

drop table if exists question_type;

drop table if exists reply;

drop table if exists role;

drop table if exists role_menu;

drop table if exists teacher_clazz;

drop table if exists topic;

drop table if exists work_clazz;

drop table if exists work_correcting;

drop table if exists work_submit;

drop table if exists student;

drop table if exists clazz;

drop table if exists grade;

drop table if exists major;

drop table if exists work;

drop table if exists teacher;

drop table if exists work_status;


-- clazz: table
CREATE TABLE `clazz`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `cno`      int(11)    DEFAULT NULL COMMENT '班级编号（班号）',
    `fk_grade` int(11)    DEFAULT NULL COMMENT '年级ID（外键）',
    `fk_major` int(11)    DEFAULT NULL COMMENT '专业ID（外键）',
    `del_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_clazz_grade` (`fk_grade`) USING BTREE,
    KEY `exam_clazz_major` (`fk_major`) USING BTREE,
    CONSTRAINT `exam_clazz_grade` FOREIGN KEY (`fk_grade`) REFERENCES `grade` (`id`),
    CONSTRAINT `exam_clazz_major` FOREIGN KEY (`fk_major`) REFERENCES `major` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='班级信息表';

-- No native definition for element: exam_clazz_grade (index)

-- No native definition for element: exam_clazz_major (index)

-- exam: table
CREATE TABLE `exam`
(
    `id`            int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `title`         varchar(50) DEFAULT NULL COMMENT '试卷标题',
    `time_limit`    int(11)     DEFAULT NULL COMMENT '考试时限（分钟）',
    `end_time`      date        DEFAULT NULL COMMENT '考试截止时间（根据运行时间计算）',
    `fk_status`     int(11)     DEFAULT NULL COMMENT '试卷运行状态（外键）',
    `fk_teacher`    int(11)     DEFAULT NULL COMMENT '出卷老师（外键）',
    `single_points` double      DEFAULT NULL COMMENT '单选题得分',
    `multi_points`  double      DEFAULT NULL COMMENT '多选题得分',
    `judge_points`  double      DEFAULT NULL COMMENT '判断题得分',
    `total_points`  double      DEFAULT NULL COMMENT '总得分',
    `del_flag`      tinyint(4)  DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_exam_techaer` (`fk_teacher`) USING BTREE,
    KEY `exam_exam_exam_status` (`fk_status`) USING BTREE,
    CONSTRAINT `exam_exam_exam_status` FOREIGN KEY (`fk_status`) REFERENCES `exam_status` (`id`),
    CONSTRAINT `exam_exam_techaer` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 21
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='试卷信息表';

-- No native definition for element: exam_exam_exam_status (index)

-- No native definition for element: exam_exam_techaer (index)

-- exam_clazz: table
CREATE TABLE `exam_clazz`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `fk_exam`  int(11)    DEFAULT NULL COMMENT '试卷ID（外键）',
    `fk_clazz` int(11)    DEFAULT NULL COMMENT '关联班级ID（外键）',
    `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_clazz_exam` (`fk_exam`) USING BTREE,
    KEY `exam_clazz_clazz` (`fk_clazz`) USING BTREE,
    CONSTRAINT `exam_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`),
    CONSTRAINT `exam_clazz_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT;

-- No native definition for element: exam_clazz_exam (index)

-- No native definition for element: exam_clazz_clazz (index)

-- exam_questions: table
CREATE TABLE `exam_questions`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `fk_exam`     int(11)    DEFAULT NULL COMMENT '关联试卷ID（外键）',
    `fk_question` int(11)    DEFAULT NULL COMMENT '题目ID（外键）',
    `fk_qtype`    int(11)    DEFAULT NULL COMMENT '题目类型ID（外键）',
    `del_flag`    tinyint(4) DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_exam_questions_exam` (`fk_exam`) USING BTREE,
    CONSTRAINT `exam_exam_questions_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 38
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='试卷题目表';

-- No native definition for element: exam_exam_questions_exam (index)

-- exam_result: table
CREATE TABLE `exam_result`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `point`      double(11, 1) DEFAULT NULL COMMENT '得分',
    `time`       date          DEFAULT NULL COMMENT '考试日期',
    `exam_title` varchar(50)   DEFAULT NULL COMMENT '试卷标题',
    `fk_exam`    int(11)       DEFAULT NULL COMMENT '关联试卷ID（外键）',
    `fk_student` int(11)       DEFAULT NULL COMMENT '关联学生ID（外键）',
    `del_flag`   tinyint(4)    DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_result_exam` (`fk_exam`) USING BTREE,
    KEY `exam_result_student` (`fk_student`) USING BTREE,
    CONSTRAINT `exam_result_exam` FOREIGN KEY (`fk_exam`) REFERENCES `exam` (`id`),
    CONSTRAINT `exam_result_student` FOREIGN KEY (`fk_student`) REFERENCES `student` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='考试结果表';

-- No native definition for element: exam_result_exam (index)

-- No native definition for element: exam_result_student (index)

-- exam_result_question: table
CREATE TABLE `exam_result_question`
(
    `id`             int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `is_right`       bit(1)      DEFAULT NULL COMMENT '是否正确（0正确，1错误）',
    `wrong_answer`   varchar(20) DEFAULT NULL COMMENT '错误答案',
    `fk_exam_result` int(11)     DEFAULT NULL COMMENT '关联试卷结果ID（外键）',
    `fk_question`    int(11)     DEFAULT NULL COMMENT '关联题目ID（非外键）',
    `fk_qtype`       int(11)     DEFAULT NULL COMMENT '题目类型ID（非外键）',
    `del_flag`       tinyint(4)  DEFAULT '0' COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_result_question_exam_result` (`fk_exam_result`) USING BTREE,
    CONSTRAINT `exam_result_question_exam_result` FOREIGN KEY (`fk_exam_result`) REFERENCES `exam_result` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT;

-- No native definition for element: exam_result_question_exam_result (index)

-- exam_status: table
CREATE TABLE `exam_status`
(
    `id`     int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `status` varchar(20) DEFAULT NULL COMMENT '状态名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='试卷状态表';

-- grade: table
CREATE TABLE `grade`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name`     varchar(50) DEFAULT NULL COMMENT '年级名称',
    `del_flag` tinyint(4)  DEFAULT '0' COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='年级信息表';

-- major: table
CREATE TABLE `major`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name`     varchar(50) DEFAULT NULL COMMENT '专业名称',
    `del_flag` tinyint(4)  DEFAULT '0' COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='专业信息表';

-- manager: table
CREATE TABLE `manager`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `username` varchar(20) DEFAULT NULL COMMENT '用户名',
    `password` varchar(50) DEFAULT NULL COMMENT '密码',
    `modified` tinyint(4)  DEFAULT '0' COMMENT '是否改过密码 0没改过  1改过',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='管理员信息表';

-- menu: table
CREATE TABLE `menu`
(
    `id`         int(9) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name`       varchar(20) CHARACTER SET utf8  DEFAULT NULL COMMENT '菜单名称',
    `url`        varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '访问路径',
    `icon`       varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '图标',
    `pid`        int(9)                          DEFAULT NULL COMMENT '父节点ID',
    `topid`      int(9)                          DEFAULT NULL COMMENT '顶级节点ID',
    `menu_level` int(1)                          DEFAULT NULL COMMENT '菜单级别',
    `sort`       int(5)                          DEFAULT NULL COMMENT '排序',
    `hidden`     int(1)                          DEFAULT NULL COMMENT '是否隐藏（0显示，1隐藏）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='菜单表';

-- message: table
CREATE TABLE `message`
(
    `message_id`      int(11)      NOT NULL AUTO_INCREMENT COMMENT '消息id',
    `from_role`       int(11)      NOT NULL DEFAULT '0' COMMENT '发送用户角色',
    `from_id`         int(11)      NOT NULL DEFAULT '0' COMMENT '发送用户id',
    `from_name`       varchar(50)  NOT NULL DEFAULT '' COMMENT '发送者姓名',
    `to_role`         int(11)      NOT NULL DEFAULT '0' COMMENT '接收角色（-1:全体,1:学生,2:教师,3:管理员,4:班级）',
    `to_id`           int(11)      NOT NULL DEFAULT '0' COMMENT '接收方（-1:全体,1-n:对应角色Id）',
    `message_title`   varchar(200) NOT NULL DEFAULT '' COMMENT '消息标题',
    `message_content` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
    `message_type`    int(11)      NOT NULL DEFAULT '0' COMMENT '消息类型(1:系统公告,2:班级通知)',
    `origin_source`   int(11)      NOT NULL DEFAULT '0' COMMENT '来源Id',
    `read_state`      int(11)      NOT NULL DEFAULT '0' COMMENT '是否已读（0：未读，1：已读）',
    `create_time`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`message_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARSET = utf8mb4 COMMENT ='消息流水表';

-- post: table
CREATE TABLE `post`
(
    `id`             int(11)      NOT NULL AUTO_INCREMENT COMMENT '帖子主键',
    `title`          varchar(200) NOT NULL DEFAULT '' COMMENT '贴子标题',
    `topic_id`       int(11)      NOT NULL DEFAULT '0' COMMENT '话题id',
    `user_id`        int(11)      NOT NULL DEFAULT '0' COMMENT '用户id',
    `user_role`      int(11)      NOT NULL DEFAULT '0' COMMENT '用户角色（1:学生，2:老师，3:管理员）',
    `user_name`      varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
    `content`        text         NOT NULL COMMENT '贴子内容',
    `reply_count`    int(11)      NOT NULL DEFAULT '0' COMMENT '回复数',
    `excellent_flag` int(11)      NOT NULL DEFAULT '0' COMMENT '精华标记',
    `top_flag`       int(11)      NOT NULL DEFAULT '0' COMMENT '置顶标记',
    `delete_flag`    int(11)      NOT NULL DEFAULT '0' COMMENT '删除标记',
    `create_time`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 26
  DEFAULT CHARSET = utf8 COMMENT ='帖子';

-- question_judge: table
CREATE TABLE `question_judge`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `title`      varchar(255)  DEFAULT NULL COMMENT '题目',
    `answer`     varchar(20)   DEFAULT NULL COMMENT '答案',
    `score`      double(11, 1) DEFAULT NULL COMMENT '分值',
    `fk_teacher` int(11)       DEFAULT NULL COMMENT '出题老师ID（非外键）',
    `fk_qtype`   int(11)       DEFAULT NULL COMMENT '试卷类型ID（非外键）',
    `del_flag`   tinyint(4)    DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `question_judge_qtype` (`fk_qtype`) USING BTREE,
    KEY `question_judge_teacher` (`fk_teacher`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='判断题信息表';

-- No native definition for element: question_judge_teacher (index)

-- No native definition for element: question_judge_qtype (index)

-- question_multi: table
CREATE TABLE `question_multi`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `title`      varchar(255)  DEFAULT NULL COMMENT '题目',
    `optionA`    varchar(100)  DEFAULT NULL COMMENT '选项A',
    `optionB`    varchar(100)  DEFAULT NULL COMMENT '选择B',
    `optionC`    varchar(100)  DEFAULT NULL COMMENT '选项C',
    `optionD`    varchar(100)  DEFAULT NULL COMMENT '选项D',
    `answer`     varchar(20)   DEFAULT NULL COMMENT '答案',
    `score`      double(11, 1) DEFAULT NULL COMMENT '分值',
    `fk_teacher` int(11)       DEFAULT NULL COMMENT '出题老师ID（非外键）',
    `fk_qtype`   int(11)       DEFAULT NULL COMMENT '试卷类型ID（非外键）',
    `del_flag`   tinyint(4)    DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `question_multi_teacher` (`fk_teacher`) USING BTREE,
    KEY `question_multi_qtype` (`fk_qtype`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='多选题信息表';

-- No native definition for element: question_multi_teacher (index)

-- No native definition for element: question_multi_qtype (index)

-- question_single: table
CREATE TABLE `question_single`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `title`      varchar(255)  DEFAULT NULL COMMENT '题目',
    `optionA`    varchar(100)  DEFAULT NULL COMMENT '选项A',
    `optionB`    varchar(100)  DEFAULT NULL COMMENT '选择B',
    `optionC`    varchar(100)  DEFAULT NULL COMMENT '选项C',
    `optionD`    varchar(100)  DEFAULT NULL COMMENT '选项D',
    `answer`     varchar(20)   DEFAULT NULL COMMENT '答案',
    `score`      double(11, 1) DEFAULT NULL COMMENT '分值',
    `fk_teacher` int(11)       DEFAULT NULL COMMENT '出题老师ID（非外键）',
    `fk_qtype`   int(11)       DEFAULT NULL COMMENT '试卷类型ID（非外键）',
    `del_flag`   tinyint(4)    DEFAULT NULL COMMENT '是否删除(0未删除，1删除) 默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `question_single_teacher` (`fk_teacher`) USING BTREE,
    KEY `question_single_qtype` (`fk_qtype`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='单选题表';

-- No native definition for element: question_single_teacher (index)

-- No native definition for element: question_single_qtype (index)

-- question_type: table
CREATE TABLE `question_type`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `type` varchar(20) DEFAULT NULL COMMENT '试卷类型',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='试卷类型表';

-- reply: table
CREATE TABLE `reply`
(
    `id`          int(11)      NOT NULL AUTO_INCREMENT COMMENT '回复注解',
    `user_role`   int(11)      NOT NULL DEFAULT '0' COMMENT '用户角色',
    `user_id`     int(11)      NOT NULL DEFAULT '0' COMMENT '用户id',
    `user_name`   varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
    `post_id`     int(11)      NOT NULL DEFAULT '0' COMMENT '帖子Id',
    `content`     text         NOT NULL COMMENT '回复内容',
    `parent_id`   int(11)      NOT NULL DEFAULT '0' COMMENT '上一级回复id',
    `reply_count` int(11)      NOT NULL DEFAULT '0' COMMENT '回复数量',
    `delete_flag` int(11)      NOT NULL DEFAULT '0' COMMENT '删除标记',
    `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 22
  DEFAULT CHARSET = utf8 COMMENT ='回复';

-- role: table
CREATE TABLE `role`
(
    `id`   int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
    `role` varchar(20) DEFAULT NULL COMMENT '角色名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='角色表';

-- role_menu: table
CREATE TABLE `role_menu`
(
    `id`      int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
    `menu_id` int(11) DEFAULT NULL COMMENT '菜单ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='角色菜单关联表';

-- student: table
CREATE TABLE `student`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `username` varchar(20) DEFAULT NULL COMMENT '用户名',
    `password` varchar(50) DEFAULT NULL COMMENT '密码',
    `realname` varchar(20) DEFAULT NULL COMMENT '真实姓名',
    `fk_clazz` int(11)     DEFAULT NULL COMMENT '关联的班级ID（外键）',
    `modified` tinyint(4)  DEFAULT '0' COMMENT '是否修改过密码（0没改，1改过）',
    `del_flag` tinyint(4)  DEFAULT NULL COMMENT '是否删除(0未删除，1删除)默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_stu_clazz` (`fk_clazz`) USING BTREE,
    CONSTRAINT `exam_stu_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='学生信息表';

-- No native definition for element: exam_stu_clazz (index)

-- teacher: table
CREATE TABLE `teacher`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `username` varchar(20) DEFAULT NULL COMMENT '用户名',
    `password` varchar(50) DEFAULT NULL COMMENT '密码',
    `realname` varchar(20) DEFAULT NULL COMMENT '真实姓名',
    `modified` tinyint(4)  DEFAULT '0' COMMENT '是否改过密码（0没改，1改过）',
    `del_flag` tinyint(4)  DEFAULT '0' COMMENT '是否删除(0未删除，1删除)默认0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='教师信息表';

-- teacher_clazz: table
CREATE TABLE `teacher_clazz`
(
    `id`         int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `fk_teacher` int(11) DEFAULT NULL COMMENT '教师ID（外键）',
    `fk_clazz`   int(11) DEFAULT NULL COMMENT '班级ID（外键）',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `exam_teacher_clazz_teacher` (`fk_teacher`) USING BTREE,
    KEY `exam_teacher_clazz_clazz` (`fk_clazz`) USING BTREE,
    CONSTRAINT `exam_teacher_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`),
    CONSTRAINT `exam_teacher_clazz_teacher` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='教师班级关联表';

-- No native definition for element: exam_teacher_clazz_teacher (index)

-- No native definition for element: exam_teacher_clazz_clazz (index)

-- topic: table
CREATE TABLE `topic`
(
    `id`          int(11)      NOT NULL AUTO_INCREMENT COMMENT '话题主键',
    `topic_name`  varchar(100) NOT NULL DEFAULT '' COMMENT '话题名',
    `delete_flag` int(11)      NOT NULL DEFAULT '0' COMMENT '删除标记',
    `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8 COMMENT ='话题';

-- work: table
CREATE TABLE `work`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `title`       varchar(50)      DEFAULT NULL COMMENT '作业标题',
    `content`     varchar(200)     DEFAULT NULL COMMENT '作业备注',
    `time_limit`  int(11)          DEFAULT NULL COMMENT '作业时限（分钟）',
    `end_time`    date             DEFAULT NULL COMMENT '作业提交截止时间（根据运行时间计算）',
    `fk_status`   int(11)          DEFAULT NULL COMMENT '作业运行状态（外键）',
    `fk_teacher`  int(11)          DEFAULT NULL COMMENT '出题老师（外键）',
    `del_flag`    tinyint(4)       DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    `ex_flag`     int(11) NOT NULL DEFAULT '0' COMMENT '是否数据实验',
    `ex_init_sql` text COMMENT '数据初始化sql',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `work_work_techaer` (`fk_teacher`) USING BTREE,
    KEY `work_work_work_status` (`fk_status`) USING BTREE,
    CONSTRAINT `work_work_techaer` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`),
    CONSTRAINT `work_work_work_status` FOREIGN KEY (`fk_status`) REFERENCES `work_status` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='作业信息表';

-- No native definition for element: work_work_work_status (index)

-- No native definition for element: work_work_techaer (index)

-- work_clazz: table
CREATE TABLE `work_clazz`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `fk_work`  int(11)    DEFAULT NULL COMMENT '作业ID（外键）',
    `fk_clazz` int(11)    DEFAULT NULL COMMENT '关联班级ID（外键）',
    `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `work_clazz_work` (`fk_work`) USING BTREE,
    KEY `work_clazz_clazz` (`fk_clazz`) USING BTREE,
    CONSTRAINT `work_clazz_clazz` FOREIGN KEY (`fk_clazz`) REFERENCES `clazz` (`id`),
    CONSTRAINT `work_clazz_work` FOREIGN KEY (`fk_work`) REFERENCES `work` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT;

-- No native definition for element: work_clazz_work (index)

-- No native definition for element: work_clazz_clazz (index)

-- work_correcting: table
CREATE TABLE `work_correcting`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT COMMENT 'id',
    `cor_time`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作业批改日期',
    `point`      double(11, 1)     DEFAULT NULL COMMENT '得分',
    `fk_submit`  int(11)           DEFAULT NULL COMMENT '关联提交作业ID（外键）',
    `fk_teacher` int(11)           DEFAULT NULL COMMENT '关联老师ID（外键）',
    `del_flag`   tinyint(4)        DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `work_result_submit` (`fk_submit`) USING BTREE,
    KEY `work_result_teacher` (`fk_teacher`) USING BTREE,
    CONSTRAINT `work_result_submit` FOREIGN KEY (`fk_submit`) REFERENCES `work_submit` (`id`),
    CONSTRAINT `work_result_teacher` FOREIGN KEY (`fk_teacher`) REFERENCES `teacher` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='教师批改作业结果表';

-- No native definition for element: work_result_submit (index)

-- No native definition for element: work_result_teacher (index)

-- work_status: table
CREATE TABLE `work_status`
(
    `id`     int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
    `status` varchar(20) DEFAULT NULL COMMENT '状态名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='作业状态表';

-- work_submit: table
CREATE TABLE `work_submit`
(
    `id`         int(11)  NOT NULL AUTO_INCREMENT COMMENT 'id',
    `sub_time`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作业提交日期',
    `work_title` varchar(50)       DEFAULT NULL COMMENT '作业标题',
    `file_url`   varchar(255)      DEFAULT NULL COMMENT '文件提交路径',
    `fk_work`    int(11)           DEFAULT NULL COMMENT '关联作业ID（外键）',
    `fk_student` int(11)           DEFAULT NULL COMMENT '关联学生ID（外键）',
    `del_flag`   tinyint(4)        DEFAULT '0' COMMENT '是否删除（0未删除 1删除）默认0',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `work_result_work` (`fk_work`) USING BTREE,
    KEY `work_result_student` (`fk_student`) USING BTREE,
    CONSTRAINT `work_result_student` FOREIGN KEY (`fk_student`) REFERENCES `student` (`id`),
    CONSTRAINT `work_result_work` FOREIGN KEY (`fk_work`) REFERENCES `work` (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4
  ROW_FORMAT = COMPACT COMMENT ='学生作业提交结果表';

-- No native definition for element: work_result_work (index)

-- No native definition for element: work_result_student (index)


