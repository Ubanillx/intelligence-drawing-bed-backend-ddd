package com.ubanillx.intelligencedrawingbed.infrastructure.repository;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ubanillx.intelligencedrawingbed.domain.space.entity.SpaceUser;
import com.ubanillx.intelligencedrawingbed.domain.space.repository.SpaceUserRepository;
import com.ubanillx.intelligencedrawingbed.infrastructure.mapper.SpaceUserMapper;
import org.springframework.stereotype.Service;

/**
 * 空间用户仓储实现
 */
@Service
public class SpaceUserRepositoryImpl extends ServiceImpl<SpaceUserMapper, SpaceUser> implements SpaceUserRepository {
}