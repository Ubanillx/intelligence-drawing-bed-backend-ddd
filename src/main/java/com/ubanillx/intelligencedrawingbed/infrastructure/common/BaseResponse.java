package com.ubanillx.intelligencedrawingbed.infrastructure.common;

import com.ubanillx.intelligencedrawingbed.infrastructure.exception.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

/**
 * 全局响应封装类
 *
 * @param <T>
 */
@Data
@AllArgsConstructor
public class BaseResponse<T> implements Serializable {

    private int code;

    private T data;

    private String message;

    public BaseResponse(int code, T data) {
        this(code, data, "");
    }

    public BaseResponse(ErrorCode errorCode) {
        this(errorCode.getCode(), null, errorCode.getMessage());
    }
}
