package com.rays.proj4.test;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rays.proj4.bean.RoleBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.RoleModel;



public class RoleModelTest {
	
public static RoleModel model=new RoleModel();

/**
 * Main method to call test methods.
 * 
 * @param args
 * @throws ParseException
 */
public static void main(String[] args) throws ParseException {
    //testAdd();//tested
    //testDelete();//tested
     testUpdate();//tested
    // testFindByPK();//tested
     //testFindByName();//tested
   // testSearch();//tested
   // testList();//tested

}

/**
 * Tests add a Role
 * 
 * @throws ParseException
 */
public static void testAdd() throws ParseException {

    try {
        RoleBean bean = new RoleBean();
      
        // SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        Date date = new Date();
        Timestamp t=new Timestamp(date.getTime());
        
       // bean.setId(1L);
        bean.setName("vijendra1");
        bean.setDescription("Mishra");
        bean.setCreatedBy("Admin");
        bean.setModifiedBy("Admin");
        bean.setCreatedDatetime(t);
        bean.setModifiedDatetime(t);
        long pk = model.add(bean);
        RoleBean addedbean = model.findByPK(pk);
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
 * Tests delete a Role
 */
public static void testDelete() {

    try {
        RoleBean bean = new RoleBean();
        long pk = 11;
        bean.setId(pk);
        model.delete(bean);
        RoleBean deletedbean = model.findByPK(pk);
        if (deletedbean != null) {
            System.out.println("Test Delete fail");
        }
    } catch (ApplicationException e) {
        e.printStackTrace();
    }
}

/**
 * Tests update a Role
 */
public static void testUpdate() {

    try {
    	long pk=7;
        RoleBean bean = model.findByPK(pk);
        bean.setName("VJM");
        bean.setDescription("Shortname");
        model.update(bean);

        RoleBean updatedbean = model.findByPK(pk);
        if (!"VJM".equals(updatedbean.getName())) {
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
        RoleBean bean = new RoleBean();
        long pk = 15L;
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
        RoleBean bean = new RoleBean();
        bean = model.findByName("vijendra");
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
 * Tests get Search
 */
public static void testSearch() {

    try {
        RoleBean bean = new RoleBean();
        List list = new ArrayList();
        bean.setName("student");
        list = model.search(bean, 0, 0);
        if (list.size() < 0) {
            System.out.println("Test Serach fail");
        }
        Iterator it = list.iterator();
        while (it.hasNext()) {
            bean = (RoleBean) it.next();
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
        RoleBean bean = new RoleBean();
        List list = new ArrayList();
        list = model.list(1, 10);
        if (list.size() < 0) {
            System.out.println("Test list fail");
        }
        Iterator it = list.iterator();
        while (it.hasNext()) {
            bean = (RoleBean) it.next();
            System.out.println(bean.getId());
            System.out.println(bean.getName());
            System.out.println(bean.getDescription());
        }

    } catch (ApplicationException e) {
        e.printStackTrace();
    }
}
}
