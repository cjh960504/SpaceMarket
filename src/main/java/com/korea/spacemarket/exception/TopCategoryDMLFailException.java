package com.korea.spacemarket.exception;

public class TopCategoryDMLFailException extends RuntimeException{
	public TopCategoryDMLFailException(String msg) {
		super(msg);
	}
	
	public TopCategoryDMLFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
