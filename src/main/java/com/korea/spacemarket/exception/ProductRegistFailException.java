package com.korea.spacemarket.exception;

public class ProductRegistFailException extends RuntimeException{
	public ProductRegistFailException(String msg) {
		super(msg);
	}
	
	public ProductRegistFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
