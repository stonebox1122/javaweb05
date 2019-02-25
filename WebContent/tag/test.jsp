<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.stone.tag.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 导入标签库(描述文件) -->    
<%@taglib uri="http://www.atguigu.com/mytag/core" prefix="atguigu" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 测试自定义EL函数 -->
	${atguigu:concat(param.name1, param.name2) };

	<!-- 使用EL函数 -->
	${fn:length(param.name) };
	
	<br>
	
	<!-- 父标签打印name到控制台 -->
	<atguigu:parentTag>
		<!-- 子标签以父标签的标签体存在，子标签把父标签的name属性打印到JSP页面上 -->
		<atguigu:sonTag/>
	</atguigu:parentTag>
	
	<br>
	
	<atguigu:choose>
		<atguigu:when test="${param.age > 24}">大学毕业</atguigu:when>
		<atguigu:when test="${param.age > 22}">高中毕业</atguigu:when>
		<atguigu:otherwise>高中以下...</atguigu:otherwise>
	</atguigu:choose>
	
	<br>

	<atguigu:testJspFragment>HelloWorld</atguigu:testJspFragment>
	
	<atguigu:printUpper time="10">abcdefg</atguigu:printUpper>
	
	<%
		List<Customer> customers = new ArrayList<Customer>();
		customers.add(new Customer(1,"aaa"));
		customers.add(new Customer(2,"bbb"));
		customers.add(new Customer(3,"ccc"));
		customers.add(new Customer(4,"ddd"));
		customers.add(new Customer(5,"eee"));
		request.setAttribute("customers", customers);
		
		Map<String, Customer> customerMap = new HashMap<String, Customer>();
		customerMap.put("a", customers.get(0));
		customerMap.put("b", customers.get(1));
		customerMap.put("c", customers.get(2));
		customerMap.put("d", customers.get(3));
		customerMap.put("e", customers.get(4));
		request.setAttribute("customerMap", customerMap);
	%>
	
	<atguigu:forEach items="${requestScope.customers }" var="cust">
		${cust.id } -- ${cust.name } <br>
	</atguigu:forEach>
	
	<br><br>
	<c:forEach items="${customerMap }" var="cust">
		--${cust.key } -- ${cust.value.id } -- ${cust.value.name } <br>
	</c:forEach>

	<%-- <atguigu:readerFile src="/WEB-INF/note.txt"/>

	<br><br>
	
	<atguigu:max num2="${param.a }" num1="${param.b }"/>
	
	<br>
	
	<atguigu:hello value="${param.name }" count="10"/> --%>
	
</body>
</html>