package com.ubanillx.intelligencedrawingbed.infrastructure.repository;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ubanillx.intelligencedrawingbed.domain.picture.entity.Picture;
import com.ubanillx.intelligencedrawingbed.domain.picture.repository.PictureRepository;
import com.ubanillx.intelligencedrawingbed.infrastructure.mapper.PictureMapper;
import org.springframework.stereotype.Service;

/**
 * 图片仓储实现
 */
@Service
public class PictureRepositoryImpl extends ServiceImpl<PictureMapper, Picture> implements PictureRepository {
}