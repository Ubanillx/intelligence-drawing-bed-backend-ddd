-- 创建库
create database if not exists intelligence_drawing_bed;

-- 切换库
use intelligence_drawing_bed;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    user_account  varchar(256)                           not null comment '账号',
    user_password varchar(512)                           not null comment '密码',
    user_name     varchar(256)                           null comment '用户昵称',
    user_avatar   varchar(1024)                          null comment '用户头像',
    user_profile  varchar(512)                           null comment '用户简介',
    user_role     varchar(256) default 'user'            not null comment '用户角色：user/admin',
    edit_time     datetime     default CURRENT_TIMESTAMP not null comment '编辑时间',
    create_time   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete     tinyint      default 0                 not null comment '是否删除',
    UNIQUE KEY uk_user_account (user_account),
    INDEX idx_user_name (user_name),
    INDEX idx_user_role (user_role),                    -- 提升按用户角色查询的性能
    INDEX idx_is_delete (is_delete),                    -- 提升按删除状态查询的性能
    INDEX idx_create_time (create_time)                 -- 提升按创建时间排序查询的性能
) comment '用户' collate = utf8mb4_unicode_ci;

-- 图片表
create table if not exists picture
(
    id           bigint auto_increment comment 'id' primary key,
    url          varchar(512)                       not null comment '图片 url',
    name         varchar(128)                       not null comment '图片名称',
    introduction varchar(512)                       null comment '简介',
    category     varchar(64)                        null comment '分类',
    tags         varchar(512)                       null comment '标签（JSON 数组）',
    pic_size      bigint                             null comment '图片体积',
    pic_width     int                                null comment '图片宽度',
    pic_height    int                                null comment '图片高度',
    pic_scale     double                             null comment '图片宽高比例',
    pic_format    varchar(32)                        null comment '图片格式',
    user_id       bigint                             not null comment '创建用户 id',
    create_time   datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    edit_time     datetime default CURRENT_TIMESTAMP not null comment '编辑时间',
    update_time   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete     tinyint  default 0                 not null comment '是否删除',
    INDEX idx_name (name),                 -- 提升基于图片名称的查询性能
    INDEX idx_introduction (introduction), -- 用于模糊搜索图片简介
    INDEX idx_category (category),         -- 提升基于分类的查询性能
    INDEX idx_tags (tags),                 -- 提升基于标签的查询性能
    INDEX idx_user_id (user_id),           -- 提升基于用户 ID 的查询性能
    INDEX idx_is_delete (is_delete),       -- 提升按删除状态查询的性能
    INDEX idx_create_time (create_time),   -- 提升按创建时间排序查询的性能
    INDEX idx_pic_format (pic_format),     -- 提升按图片格式查询的性能
    INDEX idx_user_id_create_time (user_id, create_time), -- 组合索引：用户图片按时间排序
    INDEX idx_category_create_time (category, create_time) -- 组合索引：分类图片按时间排序
) comment '图片' collate = utf8mb4_unicode_ci;


ALTER TABLE picture
    -- 添加新列
    ADD COLUMN review_status INT DEFAULT 0 NOT NULL COMMENT '审核状态：0-待审核; 1-通过; 2-拒绝',
    ADD COLUMN review_message VARCHAR(512) NULL COMMENT '审核信息',
    ADD COLUMN reviewer_id BIGINT NULL COMMENT '审核人 ID',
    ADD COLUMN review_time DATETIME NULL COMMENT '审核时间';

-- 创建基于 review_status 列的索引
CREATE INDEX idx_review_status ON picture (review_status);

-- 添加审核相关的组合索引
CREATE INDEX idx_reviewer_id_review_time ON picture (reviewer_id, review_time); -- 审核人的审核记录按时间排序
CREATE INDEX idx_review_status_review_time ON picture (review_status, review_time); -- 审核状态按时间排序

ALTER TABLE picture
    -- 添加新列
    ADD COLUMN thumbnail_url varchar(512) NULL COMMENT '缩略图 url';


-- 空间表
create table if not exists space
(
    id         bigint auto_increment comment 'id' primary key,
    space_name  varchar(128)                       null comment '空间名称',
    space_level int      default 0                 null comment '空间级别：0-普通版 1-专业版 2-旗舰版',
    max_size    bigint   default 0                 null comment '空间图片的最大总大小',
    max_count   bigint   default 0                 null comment '空间图片的最大数量',
    total_size  bigint   default 0                 null comment '当前空间下图片的总大小',
    total_count bigint   default 0                 null comment '当前空间下的图片数量',
    user_id     bigint                             not null comment '创建用户 id',
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    edit_time   datetime default CURRENT_TIMESTAMP not null comment '编辑时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_delete   tinyint  default 0                 not null comment '是否删除',
    -- 索引设计
    index idx_user_id (user_id),        -- 提升基于用户的查询效率
    index idx_space_name (space_name),  -- 提升基于空间名称的查询效率
    index idx_space_level (space_level), -- 提升按空间级别查询的效率
    INDEX idx_is_delete (is_delete),     -- 提升按删除状态查询的性能
    INDEX idx_create_time (create_time) -- 提升按创建时间排序查询的性能
) comment '空间' collate = utf8mb4_unicode_ci;

-- 添加新列
ALTER TABLE picture
    ADD COLUMN space_id bigint  null comment '空间 id（为空表示公共空间）';

-- 创建索引
CREATE INDEX idx_space_id ON picture (space_id);

-- 添加新列
ALTER TABLE picture
    ADD COLUMN pic_color varchar(16) null comment '图片主色调';

-- 创建图片颜色索引
CREATE INDEX idx_pic_color ON picture (pic_color); -- 提升按图片主色调查询的性能

-- 支持空间类型，添加新列
ALTER TABLE space
    ADD COLUMN space_type int default 0 not null comment '空间类型：0-私有 1-团队';

CREATE INDEX idx_space_type ON space (space_type);

-- 空间成员表
create table if not exists space_user
(
    id         bigint auto_increment comment 'id' primary key,
    space_id    bigint                                 not null comment '空间 id',
    user_id     bigint                                 not null comment '用户 id',
    space_role  varchar(128) default 'viewer'          null comment '空间角色：viewer/editor/admin',
    create_time datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    -- 索引设计
    UNIQUE KEY uk_space_id_user_id (space_id, user_id), -- 唯一索引，用户在一个空间中只能有一个角色
    INDEX idx_space_id (space_id),                    -- 提升按空间查询的性能
    INDEX idx_user_id (user_id),                      -- 提升按用户查询的性能
    INDEX idx_space_role (space_role),                -- 提升按空间角色查询的性能
    INDEX idx_create_time (create_time)               -- 提升按创建时间排序查询的性能
) comment '空间用户关联' collate = utf8mb4_unicode_ci;




