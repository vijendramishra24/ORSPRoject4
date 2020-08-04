package com.rays.proj4.exception;

/**
 * RecordNotFoundException thrown when a record not found occurred
 * 
 * @author Bridge
 *
 */
public class RecordNotFoundException extends Exception {
	/**
	 * : Error message
	 * @param msg
	 */
	public RecordNotFoundException(String msg) {
		super(msg);

	}
}
