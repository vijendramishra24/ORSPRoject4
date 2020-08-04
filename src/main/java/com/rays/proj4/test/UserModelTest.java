package com.rays.proj4.test;



import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import com.rays.proj4.bean.UserBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.exception.RecordNotFoundException;
import com.rays.proj4.model.UserModel;

public class UserModelTest {

	/**
     * Model object to test
     */

    public static UserModel model = new UserModel();

    /**
     * Main method to call test methods.
     * 
     * @param args
     * @throws ParseException
     * @throws DuplicateRecordException
     */
    public static void main(String[] args) throws ParseException,
            DuplicateRecordException {
       // testAdd();//tested
        //testDelete();//tested
         testUpdate();//tested
        // testFindByPK();//tested
        //testFindByLogin();//tested
         //testSearch(); //tested
         //testGetRoles();//tested
         //testList();//tested
         //testAuthenticate();//tested
        //testRegisterUser();//tested
         //testchangePassword();//tested
         
        //testforgetPassword();
        //testresetPassword();

    }

    /**
     * Tests add a User
     * 
     * @throws ParseException
     * @throws DuplicateRecordException
     */
    public static void testAdd() throws ParseException,
            DuplicateRecordException {

        try {
            UserBean bean = new UserBean();
            SimpleDateFormat sdf = new SimpleDateFormat("MM-DD-yyy");
            //Date date = new Date();
            //Timestamp t=new Timestamp(date.getTime());
            
            // bean.setId(5234L);
            bean.setFirstName("vijend");
            bean.setLastName("mishra");
            bean.setLogin("abhi12345@g.com");
            bean.setPassword("pass1234");
            bean.setDob(sdf.parse("31-12-1990"));
            bean.setRoleId(1L);
            bean.setUnSuccessfulLogin(2);
            bean.setGender("Male");
            bean.setLastLogin(new Timestamp(new Date().getTime()));
            bean.setLock("Yes");
            bean.setConfirmPassword("pass1234");
            long pk = model.add(bean);
            UserBean addedbean = model.findByPK(pk);
            System.out.println("Test add succ");
            if (addedbean == null) {
                System.out.println("Test add fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

    /**
     * Tests delete a User
     */
    public static void testDelete() {

        try {
            UserBean bean = new UserBean();
            long pk = 39L;
            bean.setId(pk);
            model.delete(bean);
            System.out.println("Test Delete succ" + bean.getId());
            UserBean deletedbean = model.findByPK(pk);
           // if (deletedbean == null) deletebean already deleted hence it will be null.
            //CORRECTION
            if (deletedbean != null) { 
                System.out.println("Test Delete fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests update a User
     */
    public static void testUpdate() {

        try {
            UserBean bean = model.findByPK(42L);
            bean.setFirstName("vjM");
            bean.setLastName("mishra");
            bean.setLogin("vijendramishra@gmail.com");
            bean.setPassword("65898");

            model.update(bean);

            UserBean updatedbean = model.findByPK(40L);
            if (!"vijendramishra88@gmail.com".equals(updatedbean.getLogin())) {
                System.out.println("Test Update fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        } catch (DuplicateRecordException e) {
            e.printStackTrace() ;
        }
    }

    /**
     * Tests find a User by PK.
     */
    public static void testFindByPK() {
        try {
            UserBean bean = new UserBean();
            long pk = 39L;
            bean = model.findByPK(pk);
            if (bean == null) {
                System.out.println("Test Find By PK fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getFirstName());
            System.out.println(bean.getLastName());
            System.out.println(bean.getLogin());
            System.out.println(bean.getPassword());
            System.out.println(bean.getDob());
            System.out.println(bean.getRoleId());
            System.out.println(bean.getUnSuccessfulLogin());
            System.out.println(bean.getGender());
            System.out.println(bean.getLastLogin());
            System.out.println(bean.getLock());
        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

    /**
     * Tests find a User by Login.
     */
    public static void testFindByLogin() {
        try {
            UserBean bean = new UserBean();
            bean = model.findByLogin("rr");
            if (bean == null) {
                System.out.println("Test Find By PK fail");
            }
            System.out.println(bean.getId());
            System.out.println(bean.getFirstName());
            System.out.println(bean.getLastName());
            System.out.println(bean.getLogin());
            System.out.println(bean.getPassword());
            System.out.println(bean.getDob());
            System.out.println(bean.getRoleId());
            System.out.println(bean.getUnSuccessfulLogin());
            System.out.println(bean.getGender());
            System.out.println(bean.getLastLogin());
            System.out.println(bean.getLock());
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests get Roles.
     */
    public static void testGetRoles() {

        try {
            UserBean bean = new UserBean();
            List list = new ArrayList();
            bean.setRoleId(2L);
            list = model.getRoles(bean);
            if (list.size() < 0) {
                System.out.println("Test Get Roles fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (UserBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getFirstName());
                System.out.println(bean.getLastName());
                System.out.println(bean.getLogin());
                System.out.println(bean.getPassword());
                System.out.println(bean.getDob());
                System.out.println(bean.getRoleId());
                System.out.println(bean.getUnSuccessfulLogin());
                System.out.println(bean.getGender());
                System.out.println(bean.getLastLogin());
                System.out.println(bean.getLock());
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests get Search
     */
    public static void testSearch() {

        try {
            UserBean bean = new UserBean();
            List list = new ArrayList();
           // bean.setId(40L);
            bean.setFirstName("v");
            list = model.search(bean, 0, 0);
            if (list.size() < 0) {
                System.out.println("Test Serach fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (UserBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getFirstName());
                System.out.println(bean.getLastName());
               /* System.out.println(bean.getLogin());
                System.out.println(bean.getPassword());
                System.out.println(bean.getDob());
                System.out.println(bean.getRoleId());
                System.out.println(bean.getUnSuccessfulLogin());
                System.out.println(bean.getGender());
                System.out.println(bean.getLastLogin());
                System.out.println(bean.getLock());*/
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
            UserBean bean = new UserBean();
            List list = new ArrayList();
            list = model.list(11, 10);
            if (list.size() < 0) {
                System.out.println("Test list fail");
            }
            Iterator it = list.iterator();
            while (it.hasNext()) {
                bean = (UserBean) it.next();
                System.out.println(bean.getId());
                System.out.println(bean.getFirstName());
                System.out.println(bean.getLastName());
                System.out.println(bean.getLogin());
                System.out.println(bean.getPassword());
                System.out.println(bean.getDob());
                System.out.println(bean.getRoleId());
                System.out.println(bean.getUnSuccessfulLogin());
                System.out.println(bean.getGender());
                System.out.println(bean.getLastLogin());
                System.out.println(bean.getLock());
                System.out.println(bean.getMobileNo());
                System.out.println(bean.getCreatedBy());
                System.out.println(bean.getModifiedBy());
                System.out.println(bean.getCreatedDatetime());
                System.out.println(bean.getModifiedDatetime());
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests authenticate User.
     */
    public static void testAuthenticate() {

        try {
            UserBean bean = new UserBean();
            bean.setLogin("k@g.co");
            bean.setPassword("rr");
            bean = model.authenticate(bean.getLogin(), bean.getPassword());
            if (bean != null) {
                System.out.println("Successfully login");

            } else {
                System.out.println("Invalied login Id & password");
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests add a User register
     * 
     * @throws ParseException
     */

    public static void testRegisterUser() throws ParseException {
        try {
            UserBean bean = new UserBean();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

            // bean.setId(8L);
            bean.setFirstName("vipin");
            // bean.setLastName("kumawat");
            bean.setLogin("rranjitch11ou1dhay@gmail.com");
            bean.setPassword("rr");
            bean.setConfirmPassword("4444");
            bean.setDob(sdf.parse("11/20/2015"));
            bean.setGender("Male");
            bean.setRoleId(2);
            long pk = model.registerUser(bean);
            System.out.println("Successfully register");
            System.out.println(bean.getFirstName());
            System.out.println(bean.getLogin());
            System.out.println(bean.getLastName());
            System.out.println(bean.getDob());
            UserBean registerbean = model.findByPK(pk);
            if (registerbean != null) {
                System.out.println("Test registation fail");
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
        } catch (DuplicateRecordException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests changepassword
     * 
     * @throws ParseException
     */
    public static void testchangePassword() {

        try {
            UserBean bean = model.findByLogin("abhi12@g.com");
            String oldPassword = bean.getPassword();
            bean.setId(15l);
            bean.setPassword("88");
            bean.setConfirmPassword("kk");
            String newPassword = bean.getPassword();
            try {
                model.changePassword(39L, oldPassword, newPassword);
                System.out.println("password has been change successfully");
            } catch (RecordNotFoundException e) {
                e.printStackTrace();
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

    /**
     * Tests fogetPassword
     * 
     * @throws ParseException
     */
    public static void testforgetPassword() {
        try {
            boolean b = model.forgetPassword("vijendramishra88@gmail.com");

            System.out.println("Suucess : Test Forget Password Success");

        } catch (RecordNotFoundException e) {
            e.printStackTrace();
        } catch (ApplicationException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests resetPassword
     * 
     * @throws ParseException
     */
    public static void testresetPassword() {
        UserBean bean = new UserBean();
        try {
            bean = model.findByLogin("ranjitchoudhary20@gmail.com");
            if (bean != null) {
                boolean pass = model.resetPassword(bean);
                if (pass = false) {
                    System.out.println("Test Update fail");
                }
            }

        } catch (ApplicationException e) {
            e.printStackTrace();
        }

    }

}
