package com.korea.spacemarket.exception;

public class ProductImageRegistFailException extends RuntimeException{
	public ProductImageRegistFailException(String msg) {
		super(msg);
	}
	
	public ProductImageRegistFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
