package com.rays.proj4.bean;

/**
 * Role JavaBean encapsulates Role attributes
 * @author Bridge
 *
 */
public class RoleBean extends BaseBean {
	/**
     * Predefined Role constants
     */
	public static final int ADMIN = 1;
    public static final int STUDENT = 2;
    public static final int COLLEGE_SCHOOL = 3;
    public static final int KIOSK = 4;
    public static final int FACULTY = 5;
//Type or category of role
    /**
     * Role Name
     */
    private String name;

//Description of role
    /**
     * Role Description
     */
    private String description;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
//method of interface 
	public String getKey() {
        return id + "";
    }
	//method of interface
    public String getValue() {
        return name;
    }

}
