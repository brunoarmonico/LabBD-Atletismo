<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Prova, controller.ControlaEvento, model.ResultadoEvento" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="./resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<title>Resultado Eventos</title>
</head>
<body>
	<% ControlaEvento cd = new ControlaEvento(); %>
	<% List<Prova> provas = cd.listarProvas(); %>
	<form action="./ControleAtletismo" method="post">
	<div>Prova: <select name="prova" id="prova">
	<% for (Prova lista : provas) { %>
	<option value="<% out.print(lista.getIdProva()); %>"> <% out.print(lista.getNomeProva()); %></option>
	<% } %>
	</select></div>
	<div>Bateria: <select name="bateria">
			<option value="1"> 1 </option>
			<option value="2"> 2 </option>
			<option value="3"> 3 </option>		
	</select></div>
	<div>Fase: <select name="fase">
		<option value="inicial"> Inicial </option>
		<option value="final"> Final </option>
	</select></div>
	<button type="submit" value="buscaResultado" name="botaoEnvio">Buscar</button>
	</form>
	<% List<ResultadoEvento> evento = (List<ResultadoEvento>)session.getAttribute("listaResultado"); %>
	<% String erro = (String)session.getAttribute("erro"); %>
	<% if (evento != null && evento.size() > 0) { %>
	<table id="tabelinha" align="center">
		<tr>
			<th>Numero do atleta</th>
			<th>Atleta</th>
			<th>Pais</th>
			<th>Resultado</th>
			<th>Posicao</th>
		</tr>
		<% for (ResultadoEvento resultado : evento) {%>
		<% System.out.println(" teste----" + resultado.getIdAtleta()); %>
		<tr>
			<td> <% out.print(resultado.getIdAtleta()); %> </td>
			<td> <% out.print(resultado.getAtleta()); %> </td>
			<td> <% out.print(resultado.getPais()); %> </td>
			<td> <% out.print(resultado.getResultado()); %> </td>
			<td> <% out.print(resultado.getPosicao()); %> </td>
		</tr>
		<% } %>
	</table>
	<% } else { %>
		<% if (erro != null) { %>
			<br>
			<h3> <% out.print(erro); %></h3>
		<% } %>
	<% } %>
	<br>
	<br>
	<form action="./ControleAtletismo" method="post">
		<div align="center">
			<button value="pgNovoAtleta" type="submit" name="botaoEnvio">Novo Atleta</button>
			<button value="psNovoResultado" type="submit" name="botaoEnvio">Novo Resultado</button>
		</div>
	</form>
</body>
</html>