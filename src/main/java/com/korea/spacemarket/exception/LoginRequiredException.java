package com.korea.spacemarket.exception;

public class LoginRequiredException extends RuntimeException{
	public LoginRequiredException(String msg) {
		super(msg);
	}
	public LoginRequiredException(String msg, Throwable e) {
		super(msg, e);
	}
}
