package com.ubanillx.intelligencedrawingbed.infrastructure.repository;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ubanillx.intelligencedrawingbed.domain.user.entity.User;
import com.ubanillx.intelligencedrawingbed.domain.user.repository.UserRepository;
import com.ubanillx.intelligencedrawingbed.infrastructure.mapper.UserMapper;
import org.springframework.stereotype.Service;

/**
 * 用户仓储实现
 */
@Service
public class UserRepositoryImpl extends ServiceImpl<UserMapper, User> implements UserRepository {
}