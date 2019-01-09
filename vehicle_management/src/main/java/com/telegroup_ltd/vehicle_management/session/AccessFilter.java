package com.telegroup_ltd.vehicle_management.session;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebFilter("/api/*")
public class AccessFilter implements Filter {


    @Value("#{'${path.public}'.split(',')}")
    private List<String> publicPaths;

    private WebApplicationContext springContext;


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        springContext = WebApplicationContextUtils.getWebApplicationContext(filterConfig.getServletContext());
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        UserBean userBean = (UserBean) springContext.getBean("userBean");
        if (!request.getRequestURI().startsWith("/api/user/register")&&!request.getRequestURI().startsWith("/api/user/check/")&& !userBean.getLoggedIn() && !publicPaths.contains(request.getRequestURI()) ) {
            response.sendError(401);
            return;
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
       // filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
