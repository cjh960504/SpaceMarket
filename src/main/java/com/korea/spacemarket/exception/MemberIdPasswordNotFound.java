package com.korea.spacemarket.exception;

public class MemberIdPasswordNotFound extends RuntimeException{
	public MemberIdPasswordNotFound(String msg) {
		super(msg);
	}
	public MemberIdPasswordNotFound(String msg, Throwable e) {
		super(msg, e);
	}
}
