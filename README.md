# 智能图床后端系统 (DDD架构)

## 项目简介

这是一个基于领域驱动设计(DDD)架构的智能图床后端系统，提供图片上传、存储、管理和分析功能。系统支持多用户、空间管理、图片审核、颜色分析等高级功能。

## 技术栈

- **框架**: Spring Boot 2.7.18
- **数据库**: MySQL + MyBatis Plus
- **缓存**: Redis + Caffeine本地缓存
- **对象存储**: 腾讯云COS
- **权限认证**: Sa-Token
- **分库分表**: Apache ShardingSphere
- **实时通信**: WebSocket
- **高性能队列**: Disruptor
- **API文档**: Knife4j
- **工具库**: Hutool

## 核心功能

### 🖼️ 图片管理
- 图片上传、下载、删除
- 图片信息管理（名称、分类、标签、简介）
- 图片格式转换和压缩
- 缩略图生成
- 图片审核机制
- 图片主色调提取和分析

### 👥 用户系统
- 用户注册、登录、权限管理
- 用户角色：普通用户、管理员
- 用户个人信息管理

### 🏢 空间管理
- 私有空间和团队空间
- 空间级别：普通版、专业版、旗舰版
- 空间容量和图片数量限制
- 空间成员管理（查看者、编辑者、管理员）

### 📊 数据分析
- 空间使用情况分析
- 图片统计和报表
- 颜色相似度分析

### 🔍 智能搜索
- 基于图片名称、标签、分类的搜索
- 图片相似度搜索
- 颜色搜索功能

## 项目架构

项目采用DDD（领域驱动设计）架构，主要分为以下层次：

```
├── application/          # 应用服务层
├── domain/              # 领域层
│   ├── picture/         # 图片领域
│   ├── space/           # 空间领域
│   └── user/            # 用户领域
├── infrastructure/      # 基础设施层
├── interfaces/          # 接口层
└── shared/             # 共享层
```

## 数据库设计

主要数据表：
- `user`: 用户表
- `picture`: 图片表
- `space`: 空间表
- `space_user`: 空间用户关联表

## 快速开始

### 环境要求
- JDK 11+
- MySQL 8.0+
- Redis 6.0+
- Maven 3.6+

### 安装步骤

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd intelligence-drawing-bed-backend-ddd
   ```

2. **数据库初始化**
   ```bash
   # 执行SQL脚本
   mysql -u root -p < sql/create_table.sql
   ```

3. **配置文件**
   - 配置数据库连接信息
   - 配置Redis连接信息
   - 配置腾讯云COS信息

4. **启动项目**
   ```bash
   mvn spring-boot:run
   ```

5. **访问接口文档**
   ```
   http://localhost:8123/doc.html
   ```

## API接口

### 图片相关
- `POST /api/picture/upload` - 上传图片
- `GET /api/picture/list` - 获取图片列表
- `DELETE /api/picture/delete` - 删除图片
- `PUT /api/picture/update` - 更新图片信息

### 用户相关
- `POST /api/user/register` - 用户注册
- `POST /api/user/login` - 用户登录
- `GET /api/user/get/login` - 获取当前登录用户

### 空间相关
- `POST /api/space/add` - 创建空间
- `GET /api/space/list` - 获取空间列表
- `POST /api/space/user/add` - 添加空间成员

## 特色功能

### 🎨 智能颜色分析
- 自动提取图片主色调
- 颜色相似度计算
- 基于颜色的图片搜索

### 🔄 实时协作
- WebSocket实时通信
- 多用户同时编辑
- 实时状态同步

### ⚡ 高性能设计
- Disruptor高性能队列
- 多级缓存策略
- 分库分表支持

### 🛡️ 安全机制
- Sa-Token权限认证
- 图片审核机制
- 接口权限控制

## 开发规范

- 遵循DDD设计原则
- 使用统一的异常处理
- 接口返回统一格式
- 完善的日志记录

## 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 联系方式

如有问题或建议，请提交 Issue 或联系项目维护者。