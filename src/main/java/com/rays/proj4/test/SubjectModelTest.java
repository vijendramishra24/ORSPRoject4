package com.rays.proj4.test;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rays.proj4.bean.SubjectBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.SubjectModel;

import java.util.*;
import java.sql.*;

public class SubjectModelTest {
	public static SubjectModel model=new SubjectModel();

	/**
	 * Main method to call test methods.
	 * 
	 * @param args
	 * @throws ParseException
	 */
	public static void main(String[] args) throws ParseException {
	    //testAdd();//tested
	    //testDelete();//tested
	    //testUpdate();//tested
	    // testFindByPK();//Problem: Commented--> CREATED_DATETIME and MODIFIED_DATETIME field
	    //testFindByName();//Problem: Commented--> CREATED_DATETIME and MODIFIED_DATETIME field
	   // testSearch();//tested :Problem: Commented--> CREATED_DATETIME and MODIFIED_DATETIME field
	   //testList();//tested:problem datetime---datetime

	}

	/**
	 * Tests add a Subject
	 * 
	 * @throws ParseException
	 */
	public static void testAdd() throws ParseException {

	    try {
	        SubjectBean bean = new SubjectBean();
	      
	        // SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	        Date date = new Date();
	        Timestamp t=new Timestamp(date.getTime());
	        
	        //bean.setId(11);
	        bean.setName("python");
	        bean.setDescription("language");
	        bean.setSubjectCode("6CS05");
	        bean.setCreatedBy("Admin");
	        bean.setModifiedBy("Admin");
	        bean.setCreatedDatetime(t);
	        bean.setModifiedDatetime(t);
	        bean.setCourseId(2);
	        long pk = model.add(bean);
	        SubjectBean addedbean = model.findByPK(pk);
	        if (addedbean == null) {
	            System.out.println("Test add fail");
	        }
	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    } catch (DuplicateRecordException e) {
	        e.printStackTrace();
	    }

	}

	/**
	 * Tests delete a Subject
	 */
	public static void testDelete() {

	    try {
	        SubjectBean bean = new SubjectBean();
	        long pk = 11;
	        bean.setId(pk);
	        model.delete(bean);
	        SubjectBean deletedbean = model.findByPK(pk);
	        if (deletedbean != null) {
	            System.out.println("Test Delete fail");
	        }
	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    }
	}

	/**
	 * Tests update a Subject
	 */
	public static void testUpdate() {

	    try {
	    	long pk=11;
	        SubjectBean bean = model.findByPK(pk);
	        bean.setName("ADC");
	        bean.setDescription("Analog Comm");
	        model.update(bean);

	        SubjectBean updatedbean = model.findByPK(pk);
	        if (!"ADC".equals(updatedbean.getName())) {
	            System.out.println("Test Update fail");
	        }
	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    } catch (DuplicateRecordException e) {
	        e.printStackTrace();
	    }
	}

	/**
	 * Tests find a User by PK.
	 */
	public static void testFindByPK() {
	    try {
	        SubjectBean bean = new SubjectBean();
	        long pk = 10;
	        bean = model.findByPK(pk);
	        if (bean == null) {
	            System.out.println("Test Find By PK fail");
	        }
	        System.out.println(bean.getId());
	        System.out.println(bean.getName());
	        System.out.println(bean.getDescription());
	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    }

	}

	/**
	 * Tests find a User by Name.
	 */
	public static void testFindByName() {
	    try {
	        SubjectBean bean = new SubjectBean();
	        bean = model.findByName("NAS");
	        if (bean == null) {
	            System.out.println("Test Find By name fail");
	        }
	        System.out.println(bean.getId());
	        System.out.println(bean.getName());
	        System.out.println(bean.getDescription());
	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    }
	}

	/**
	 * Tests get Search
	 */
	public static void testSearch() {

	    try {
	        SubjectBean bean = new SubjectBean();
	        List list = new ArrayList();
	        bean.setName("E");
	        list = model.search(bean, 0, 0);
	        if (list.size() < 0) {
	            System.out.println("Test Serach fail");
	        }
	        Iterator it = list.iterator();
	        while (it.hasNext()) {
	            bean = (SubjectBean) it.next();
	            System.out.println(bean.getId());
	            System.out.println(bean.getName());
	            System.out.println(bean.getDescription());
	        }

	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    }

	}

	/**
	 * Tests get List.
	 */
	public static void testList() {

	    try {
	        SubjectBean bean = new SubjectBean();
	        List list = new ArrayList();
	        list = model.list(1, 10);
	        if (list.size() < 0) {
	            System.out.println("Test list fail");
	        }
	        Iterator it = list.iterator();
	        while (it.hasNext()) {
	            bean = (SubjectBean) it.next();
	            System.out.println(bean.getId());
	            System.out.println(bean.getName());
	            System.out.println(bean.getDescription());
	            
	        }

	    } catch (ApplicationException e) {
	        e.printStackTrace();
	    }
	}


}
