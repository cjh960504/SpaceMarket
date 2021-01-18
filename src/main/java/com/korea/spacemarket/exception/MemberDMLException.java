package com.korea.spacemarket.exception;

public class MemberDMLException extends RuntimeException{
	public MemberDMLException(String msg) {
		super(msg);
	}
	public MemberDMLException(String msg, Throwable e) {
		super(msg, e);
	}
}
