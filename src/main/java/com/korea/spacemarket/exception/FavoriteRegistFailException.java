package com.korea.spacemarket.exception;

public class FavoriteRegistFailException extends RuntimeException{
	public FavoriteRegistFailException(String msg) {
		super(msg);
	}
	
	public FavoriteRegistFailException(String msg, Throwable e) {
		super(msg, e);
	}
}
