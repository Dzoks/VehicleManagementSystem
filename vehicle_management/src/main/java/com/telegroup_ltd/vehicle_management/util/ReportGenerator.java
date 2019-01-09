package com.telegroup_ltd.vehicle_management.util;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.*;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Component
public class ReportGenerator {

    final
    JdbcTemplate jdbcTemplate;

    JasperReport jasperReport;

    Connection connection;

    @Autowired
    public ReportGenerator(JdbcTemplate jdbcTemplate) throws JRException, SQLException {
        InputStream employeeReportStream
                = getClass().getResourceAsStream("/report.jrxml");
       jasperReport = JasperCompileManager.compileReport(employeeReportStream);
        this.jdbcTemplate = jdbcTemplate;
        connection=jdbcTemplate.getDataSource().getConnection();
    }

    public byte[] generateReport(String type, Integer companyId, Timestamp start,Timestamp end) throws IOException, JRException {
        Map<String, Object> params=new HashMap<>();
        params.put("CompanyId",companyId);
        params.put("Month",start.toLocalDateTime().getMonthValue()+"/"+start.toLocalDateTime().getYear());
        params.put("StartDate",start);
        params.put("EndDate",end);
        return generateDocument(type,params);
    }

    private byte[] generateDocument(String type,Map<String, Object> params) throws JRException, IOException {
        byte[] bytes = null;
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params,connection);
        String filename= RandomStringUtils.randomAlphanumeric(30);

        switch (type){
            case "PDF":
                JRPdfExporter exporter = new JRPdfExporter();
                exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                exporter.setExporterOutput(
                        new SimpleOutputStreamExporterOutput(filename));
                SimplePdfReportConfiguration reportConfig
                        = new SimplePdfReportConfiguration();
                reportConfig.setSizePageToContent(true);
                reportConfig.setForceLineBreakPolicy(false);
                exporter.setConfiguration(reportConfig);
                exporter.exportReport();
                break;
            case "XLS":
                JRXlsxExporter xlsexporter = new JRXlsxExporter();
                xlsexporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                xlsexporter.setExporterOutput(
                        new SimpleOutputStreamExporterOutput(filename));
                SimpleXlsxReportConfiguration xlsreportConfig
                        = new SimpleXlsxReportConfiguration();
                xlsreportConfig.setSheetNames(new String[] { "Troškovi" });

                xlsexporter.setConfiguration(xlsreportConfig);
                xlsexporter.exportReport();
                break;
            case "CSV":
                JRCsvExporter csvexporter = new JRCsvExporter();
                csvexporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                csvexporter.setExporterOutput(
                        new SimpleWriterExporterOutput(filename));
                csvexporter.exportReport();
                break;
        }
        Path filePath=Paths.get(filename);
        bytes= Files.readAllBytes(filePath);
        Files.delete(filePath);
        return bytes;
    }


}
