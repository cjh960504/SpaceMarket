package com.korea.spacemarket.exception;

public class ProductImageDeleteFailException extends RuntimeException{
	public ProductImageDeleteFailException(String msg) {
		super(msg);
	}
	
	public ProductImageDeleteFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
