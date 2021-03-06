package com.rays.proj4.ctl;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.rays.proj4.bean.BaseBean;
import com.rays.proj4.bean.MarksheetBean;
import com.rays.proj4.exception.ApplicationException;
import com.rays.proj4.exception.DuplicateRecordException;
import com.rays.proj4.model.MarksheetModel;
import com.rays.proj4.model.StudentModel;
import com.rays.proj4.util.DataUtility;
import com.rays.proj4.util.DataValidator;
import com.rays.proj4.util.PropertyReader;
import com.rays.proj4.util.ServletUtility;

/**
 * Marksheet functionality Controller. Performs operation for add, update,
 * delete and get Marksheet
 * @author Bridge
 *
 */
@ WebServlet(name="MarksheetCtl",urlPatterns={"/ctl/MarksheetCtl"})
public class MarksheetCtl extends BaseCtl {

    private static Logger log = Logger.getLogger(MarksheetCtl.class);

    @Override
    protected void preload(HttpServletRequest request) {
        StudentModel model = new StudentModel();
        try {
            List l = model.list();
            request.setAttribute("studentList", l);
        } catch (ApplicationException e) {
            log.error(e);
        }

    }

    @Override
    protected boolean validate(HttpServletRequest request) {

        log.debug("MarksheetCtl Method validate Started");
        System.out.println("marksheet validate start");

        boolean pass = true;

        if (DataValidator.isNull(request.getParameter("rollNo"))) {
            request.setAttribute("rollNo",
                    PropertyReader.getValue("error.require", "Roll Number"));
            pass = false;
        }
        else if (!DataValidator.isRollNo(request.getParameter("rollNo"))) {
            request.setAttribute("rollNo",
                    PropertyReader.getValue("error.rollformat", "Roll Number"));
            pass = false;
        }
        if (request.getParameter("studentId").equals("---select---")) {
			request.setAttribute("studentId", PropertyReader.getValue("error.select", "Name"));
			pass = false;
		}    
        
        /*if (DataValidator.isNotNull(request.getParameter("physics"))
                && !DataValidator.isInteger(request.getParameter("physics"))) {
            request.setAttribute("physics",
                    PropertyReader.getValue("error.integer", "Marks"));
            pass = false;
        }   */
        
        if (DataValidator.isNull(request.getParameter("physics"))){
            request.setAttribute("physics", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        } 
        
        else if (!DataValidator.isInteger(request.getParameter("physics"))){
            request.setAttribute("physics", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        } 

        else if ((DataUtility.getInt(request.getParameter("physics")) > 100)||(DataUtility.getInt(request.getParameter("physics")) < 0)) {
            request.setAttribute("physics", "Marks should be 0 to 100");
            pass = false;
        }       
       

        if (DataValidator.isNull(request.getParameter("chemistry"))){
            request.setAttribute("chemistry", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        } 
        
        else if (!DataValidator.isInteger(request.getParameter("chemistry"))){
            request.setAttribute("chemistry", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        } 

        
        else if ((DataUtility.getInt(request.getParameter("chemistry")) > 100)||(DataUtility.getInt(request.getParameter("chemistry")) < 0)) {
            request.setAttribute("chemistry",
                    "Marks should be 0 to 100");
            pass = false;
        }
        
       
        if (DataValidator.isNull(request.getParameter("maths"))){
            request.setAttribute("maths", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        } 
        
        else if (!DataValidator.isInteger(request.getParameter("maths"))){
            request.setAttribute("maths", PropertyReader.getValue("error.require", "Marks"));
            pass = false;
        }

        else if ((DataUtility.getInt(request.getParameter("maths")) > 100)||(DataUtility.getInt(request.getParameter("maths")) < 0)) {
            request.setAttribute("maths", "Marks should be 0 to 100");
            pass = false;
        }

        

        log.debug("MarksheetCtl Method validate Ended");

        System.out.println("marksheet validate ends -- falg:"+pass);
        return pass;
    }

    @Override
    protected BaseBean populateBean(HttpServletRequest request) {

        log.debug("MarksheetCtl Method populatebean Started");

        MarksheetBean bean = new MarksheetBean();

        bean.setId(DataUtility.getLong(request.getParameter("id")));

        bean.setRollNo(DataUtility.getString(request.getParameter("rollNo")));

        bean.setName(DataUtility.getString(request.getParameter("name")));

        if (DataValidator.isNotNull(request.getParameter("physics"))){ 
        bean.setPhysics(DataUtility.getInt(request.getParameter("physics")));
        }
        if (DataValidator.isNotNull(request.getParameter("chemistry"))){ 
        bean.setChemistry(DataUtility.getInt(request.getParameter("chemistry")));
        }
        if (DataValidator.isNotNull(request.getParameter("maths"))){ 
        bean.setMaths(DataUtility.getInt(request.getParameter("maths")));
        }
        bean.setStudentId(DataUtility.getLong(request.getParameter("studentId")));

        populateDTO(bean, request);

        System.out.println("Populate done");

        log.debug("MarksheetCtl Method populatebean Ended");

        return bean;
    }

    /**
     * Contains Display logics
     */
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("MarksheetCtl Method doGet Started");

        String op = DataUtility.getString(request.getParameter("operation"));
        MarksheetModel model = new MarksheetModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        if (id > 0) {
            MarksheetBean bean;
            try {
                bean = model.findByPK(id);
                ServletUtility.setBean(bean, request);
            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }
        }
        System.out.println("markctl doget");
        ServletUtility.forward(getView(), request, response);
        log.debug("MarksheetCtl Method doGet Ended");
    }

    /**
     * Contains Submit logics
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        log.debug("MarksheetCtl Method doPost Started");

        
        System.out.println("dopost--start");
        String op = DataUtility.getString(request.getParameter("operation"));
        // get model
        MarksheetModel model = new MarksheetModel();
        long id = DataUtility.getLong(request.getParameter("id"));
        System.out.println("dopost--getid");
        
        if (OP_SAVE.equalsIgnoreCase(op)||OP_UPDATE.equalsIgnoreCase(op)) {

        	System.out.println("dopost--save");
            MarksheetBean bean = (MarksheetBean) populateBean(request);
            try {
                if (id > 0) {
                	
                    model.update(bean);
                } else {
                	System.out.println("dopost--save-addstart");

                	long pk = model.add(bean);
                	System.out.println("dopost--save--addends");

                    bean.setId(pk);
                }
                System.out.println("dopost--lastcheck");

                ServletUtility.setBean(bean, request);
                ServletUtility.setSuccessMessage("Data is successfully saved", request);

            } catch (ApplicationException e) {
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            } catch (DuplicateRecordException e) {
                ServletUtility.setBean(bean, request);
                ServletUtility.setErrorMessage("Roll no already exists", request);
            }

        } else if (OP_DELETE.equalsIgnoreCase(op)) {

            MarksheetBean bean = (MarksheetBean) populateBean(request);
            System.out.println("in try");
            try {
                model.delete(bean);
                ServletUtility.redirect(ORSView.MARKSHEET_LIST_CTL, request,
                        response);
                System.out.println("in try");
                return;
            } catch (ApplicationException e) {
                System.out.println("in catch");
                log.error(e);
                ServletUtility.handleException(e, request, response);
                return;
            }

        } else if (OP_CANCEL.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.MARKSHEET_LIST_CTL, request,
                    response);
            return;

        }
        
        else if (OP_RESET.equalsIgnoreCase(op)) {

            ServletUtility.redirect(ORSView.MARKSHEET_CTL, request,
                    response);
            return;

        }
        ServletUtility.forward(getView(), request, response);

        log.debug("MarksheetCtl Method doPost Ended");
    }

    @Override
    protected String getView() {
    	System.out.println("markctl view");
        return ORSView.MARKSHEET_VIEW;
    }

}