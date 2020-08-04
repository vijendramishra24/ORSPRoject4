package com.rays.proj4.test;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rays.proj4.bean.TimetableBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.StudentModel;
import com.rays.proj4.model.TimetableModel;

public class TimetableModelTest {
	
	/**
     * Model object to test
     */

    public static TimetableModel model = new TimetableModel();

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
        // testFindByPK();//tested
         // testfindDuplicate1();//tested
        // testSearch();//tested
        testList();//tested

    }

    /**
     * Tests add a Student
     * 
     * @throws ParseException
     */
    public static void testAdd() throws ParseException {

        try {
            TimetableBean bean = new TimetableBean();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

            // bean.setId(1L);
            bean.setCourseId(10L);
            bean.setSem("2");
            bean.setSubjectId(2);
            bean.setExamDate(sdf.parse("2018/09/23"));
            bean.setExamTime("3:00 PM");
            bean.setCreatedBy("Admin");
            bean.setModifiedBy("Admin");
            bean.setCreatedDatetime(new Timestamp(new Date().getTime()));
            bean.setModifiedDatetime(new Timestamp(new Date().getTime()));
            long pk = model.add(bean);
            TimetableBean addedbean = model.findByPK(pk);
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
            TimetableBean bean = new TimetableBean();
            long pk = 2L;
            bean.setId(pk);
            model.delete(bean);
            TimetableBean deletedbean = model.findByPK(pk);
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
long pk=5L;
        try {
            TimetableBean bean = model.findByPK(pk);
            bean.setCourseId(34);;
            bean.setSem("4");
            bean.setSubjectId(4);
            model.update(bean);

            TimetableBean updatedbean = model.findByPK(pk);
            if (!"EC".equals(updatedbean.getCourseId())) {
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
            TimetableBean bean = new TimetableBean();
            long pk = 25L;
            bean = model.findByPK(pk);
            if (bean == null) {
                System.out.println("Test Find By PK fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getCourseId());
            System.out.println(bean.getSem());
            System.out.println(bean.getSubjectId());
            System.out.println(bean.getExamDate());
            System.out.println(bean.getExamTime());
           
        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

    /**
     * Tests find a Student by Emailid.
     */
    /*public static void testfindDuplicate1() {
        try {
            TimetableBean bean = new TimetableBean();
            bean = model.findDuplicate1(3,"2",201,2018/8/14);
            if (bean == null) {
                System.out.println("Test Find By EmailId fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getCourseId());
            System.out.println(bean.getSem());
            System.out.println(bean.getSubjectId());
            System.out.println(bean.getExamDate());
            System.out.println(bean.getExamTime());
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests get Search
     */
    public static void testSearch() {

        try {
            TimetableBean bean = new TimetableBean();
            List list = new ArrayList();
            bean.setCourseId(3);
            list = model.search(bean, 0, 0);
            if (list.size() < 0) {
                System.out.println("Test Serach fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (TimetableBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getCourseId());
                System.out.println(bean.getSem());
                System.out.println(bean.getSubjectId());
                System.out.println(bean.getExamDate());
                System.out.println(bean.getExamTime());
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
            TimetableBean bean = new TimetableBean();
            List list = new ArrayList();
            list = model.list(1, 10);
            if (list.size() < 0) {
                System.out.println("Test list fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (TimetableBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getCourseId());
                System.out.println(bean.getSem());
                System.out.println(bean.getSubjectId());
                System.out.println(bean.getExamDate());
                System.out.println(bean.getExamTime());
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }




}
