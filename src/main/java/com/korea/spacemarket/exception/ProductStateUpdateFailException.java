package com.korea.spacemarket.exception;

public class ProductStateUpdateFailException extends RuntimeException{
	public ProductStateUpdateFailException(String msg) {
		super(msg);
	}
	
	public ProductStateUpdateFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
