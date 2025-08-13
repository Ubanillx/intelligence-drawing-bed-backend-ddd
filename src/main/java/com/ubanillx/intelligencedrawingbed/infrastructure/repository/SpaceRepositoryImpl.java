package com.ubanillx.intelligencedrawingbed.infrastructure.repository;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ubanillx.intelligencedrawingbed.domain.space.entity.Space;
import com.ubanillx.intelligencedrawingbed.domain.space.repository.SpaceRepository;
import com.ubanillx.intelligencedrawingbed.infrastructure.mapper.SpaceMapper;
import org.springframework.stereotype.Service;

/**
 * 空间仓储实现
 */
@Service
public class SpaceRepositoryImpl extends ServiceImpl<SpaceMapper, Space> implements SpaceRepository {
}