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
<div class="p-3 mb-2 bg-dark text-white">
<h4 align="center">Cadastro de Atleta</h4>
<hr>
</div>
	<% ControlaEvento ctrEvento = new ControlaEvento(); %>
	<% List<Pais> paises = ctrEvento.recebePaises(); %>
	
	<!-- Retorna mensagem de erro ou acerto do SQL -->
	<% String erro = (String)session.getAttribute("erroAtleta"); %>
	<% String sucesso = (String)session.getAttribute("sucessoAtleta"); %>
	<% if (erro != null) { %>
		<div class="alert alert-danger" role="alert"><h4><% out.print(erro); %></h4></div>
	<% } else if (sucesso != null) { %>
		<div class="alert alert-success" role="alert"><h4><% out.print(sucesso); %></h4></div>
	<% } %>
	
	<form action="./ControleAtletismo" method="post">
	<div>Nome Atleta: <input type="text" name="nome"/></div>
	<div>Pais: <select name="pais">
		<% for (Pais lista : paises){%>
		<option value="<% out.print(lista.getCodigo()); %>"> <% out.print(lista.getNome()); %> </option>
		<% } %>
	</select></div>
	
	<div>Sexo :<select name="sexo">
		<option value="m"> Masculino </option>
		<option value="f"> Feminino </option>
	</select></div>
	
	<!-- Botão de cadastro de novo atleta -->
	<button value="novoAtleta" type="submit" name="botaoEnvio"> Enviar </button>
	</form>
</body>
</html>