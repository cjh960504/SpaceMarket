package com.korea.spacemarket.exception;

public class SubCategoryDMLFailException extends RuntimeException{
	public SubCategoryDMLFailException(String msg) {
		super(msg);
	}
	
	public SubCategoryDMLFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
