package com.rays.proj4.test;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rays.proj4.bean.StudentBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.StudentModel;

public class StudentModelTest {

	
	 /**
     * Model object to test
     */

    public static StudentModel model = new StudentModel();

    /**
     * Main method to call test methods.
     * 
     * @param args
     * @throws ParseException
     */
    public static void main(String[] args) throws ParseException {
        // testAdd();//tested
         //testDelete();//tested
        // testUpdate();//tested
        // testFindByPK();//tested
         // testFindByEmailId();//tested
        // testSearch();
        testList();//tested

    }

    /**
     * Tests add a Student
     * 
     * @throws ParseException
     */
    public static void testAdd() throws ParseException {

        try {
            StudentBean bean = new StudentBean();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

            // bean.setId(1L);
            bean.setFirstName("vijendraStu");
            bean.setLastName("mishra");
            bean.setDob(sdf.parse("1990/08/23"));
            bean.setMobileNo("9165254357");
            bean.setEmail("vijendra.mishra@gmail.com");
            bean.setCollegeId(2L);
            bean.setCreatedBy("Admin");
            bean.setModifiedBy("Admin");
            bean.setCreatedDatetime(new Timestamp(new Date().getTime()));
            bean.setModifiedDatetime(new Timestamp(new Date().getTime()));
            long pk = model.add(bean);
            StudentBean addedbean = model.findByPK(pk);
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
     * Tests delete a Student
     */
    public static void testDelete() {

        try {
            StudentBean bean = new StudentBean();
            long pk = 44L;
            bean.setId(pk);
            model.delete(bean);
            StudentBean deletedbean = model.findByPK(pk);
            if (deletedbean != null) {
                System.out.println("Test Delete fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests update a Student
     */
    public static void testUpdate() {
long pk=26L;
        try {
            StudentBean bean = model.findByPK(pk);
            bean.setCollegeId(2L);
            bean.setFirstName("VijendraStudent");
            bean.setLastName("sharma");
            model.update(bean);

            StudentBean updatedbean = model.findByPK(pk);
            if (!"VijendraStudent".equals(updatedbean.getFirstName())) {
                System.out.println("Test Update fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        } catch (DuplicateRecordException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests find a Student by PK.
     */
    public static void testFindByPK() {
        try {
            StudentBean bean = new StudentBean();
            long pk = 25L;
            bean = model.findByPK(pk);
            if (bean == null) {
                System.out.println("Test Find By PK fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getFirstName());
            System.out.println(bean.getLastName());
            System.out.println(bean.getDob());
            System.out.println(bean.getMobileNo());
            System.out.println(bean.getEmail());
            System.out.println(bean.getCollegeId());
        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

    /**
     * Tests find a Student by Emailid.
     */
    public static void testFindByEmailId() {
        try {
            StudentBean bean = new StudentBean();
            bean = model.findByEmailId("rahul@gmail.com");
            if (bean == null) {
                System.out.println("Test Find By EmailId fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getFirstName());
            System.out.println(bean.getLastName());
            System.out.println(bean.getDob());
            System.out.println(bean.getMobileNo());
            System.out.println(bean.getEmail());
            System.out.println(bean.getCollegeId());
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests get Search
     */
    public static void testSearch() {

        try {
            StudentBean bean = new StudentBean();
            List list = new ArrayList();
            bean.setFirstName("r");
            list = model.search(bean, 0, 0);
            if (list.size() < 0) {
                System.out.println("Test Serach fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (StudentBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getFirstName());
                System.out.println(bean.getLastName());
                System.out.println(bean.getDob());
                System.out.println(bean.getMobileNo());
                System.out.println(bean.getEmail());
                System.out.println(bean.getCollegeId());
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
            StudentBean bean = new StudentBean();
            List list = new ArrayList();
            list = model.list(1, 10);
            if (list.size() < 0) {
                System.out.println("Test list fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (StudentBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getFirstName());
                System.out.println(bean.getLastName());
                System.out.println(bean.getDob());
                System.out.println(bean.getMobileNo());
                System.out.println(bean.getEmail());
                System.out.println(bean.getCollegeId());
                System.out.println(bean.getCreatedBy());
                System.out.println(bean.getCreatedDatetime());
                System.out.println(bean.getModifiedBy());
                System.out.println(bean.getModifiedDatetime());
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

}
