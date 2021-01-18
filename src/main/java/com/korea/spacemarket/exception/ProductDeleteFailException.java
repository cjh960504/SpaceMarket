package com.korea.spacemarket.exception;

public class ProductDeleteFailException extends RuntimeException{
	public ProductDeleteFailException(String msg) {
		super(msg);
	}
	
	public ProductDeleteFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
