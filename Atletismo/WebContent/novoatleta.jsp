<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Pais, controller.ControlaEvento" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="./resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<title>Novo Atleta</title>
</head>
<body>
	<% ControlaEvento cd = new ControlaEvento(); %>
	<% List<Pais> paises = cd.recebePaises(); %>
	<form action="./ControleAtletismo" method="post">
	Nome Atleta: <input type="text" name="nome"/>
	Pais: <select name="pais">
	<% for (Pais lista : paises){%>
	<option value="<% out.print(lista.getCodigo()); %>"> <% out.print(lista.getNome()); %> </option>
	<% } %>
	</select>
	Sexo :<select name="sexo">
		<option value="m"> Masculino </option>
		<option value="f"> Feminino </option>
	</select>
	<button value="novoAtleta" type="submit" name="botaoEnvio"> Enviar </button>
	</form>
</body>
</html>