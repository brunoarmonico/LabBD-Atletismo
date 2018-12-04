<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Prova, controller.ControlaEvento, model.ResultadoEvento, model.Record" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="./resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<title>Resultado Eventos</title>
</head>
<body>
<div class="p-3 mb-2 bg-dark text-white">
<h2 align="center">Evento de Atletismo</h2>
<hr>
</div>
	<% ControlaEvento ctrEvento = new ControlaEvento(); %>
	
	<!-- Busca lista de provas -->
	<% List<Prova> provas = ctrEvento.listarProvas(); %>
	<form action="./ControleAtletismo" method="post">
	<div>Prova: <select name="prova" id="prova">
	<!-- Lista as provas em uma combobox -->
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
	
	<!-- Recebe resultados e recordes -->
	<% List<ResultadoEvento> evento = (List<ResultadoEvento>)session.getAttribute("listaResultado"); %>
	<% List<Record> record = (List<Record>)session.getAttribute("listaRecord"); %>
	<% if (record == null || record.isEmpty()) { 
		record = ctrEvento.listarRecordes(1);
	} %>
	
	<div align="center"> <h3>Recorde da Prova</h3> </div>
		<table align="center" class="table table-striped">
		<tr>
			<th>Nome do Atleta</th>
			<th>Pais</th>
			<th>Resultado</th>
			<th>Recorde</th>
		</tr>
		<% for (Record recorde : record) {
			if (recorde.getCor() == null){
				recorde.setCor("white");
			} %>
		<tr>
			<td bgcolor="<% out.print(recorde.getCor()); %>"><% out.print(recorde.getNome()); %></td>
			<td bgcolor="<% out.print(recorde.getCor()); %>"><% out.print(recorde.getPais()); %></td>
			<td bgcolor="<% out.print(recorde.getCor()); %>"><% out.print(recorde.getResultado()); %></td>
			<td bgcolor="<% out.print(recorde.getCor()); %>"><% out.print(recorde.getTipo()); %></td>
		</tr>
		<% } %>
		</table>
	<br>
	<% String erro = (String)session.getAttribute("erro"); %>
	<br>
	<% if (evento != null && evento.size() > 0) { %>
	<div align="center"> <h3>Resultados da Prova</h3> </div>
	<table id="tabelinha" align="center" class="table table-striped">
		<tr>
			<th>Numero do atleta</th>
			<th>Atleta</th>
			<th>Pais</th>
			<th>Resultado</th>
			<th>Posicao</th>
		</tr>
		<% for (ResultadoEvento resultado : evento) {%>
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
			
			<h5 class="alert alert-warning" role="alert"> <% out.print(erro); %></h5>
		<% } %>
	<% } %>
	<br>
	<br>
	<form action="./ControleAtletismo" method="post">
		<div align="center">
			<button value="pgNovoAtleta" type="submit" name="botaoEnvio" class="btn default">Novo Atleta</button>
			<button value="psNovoResultado" type="submit" name="botaoEnvio" class="btn default">Novo Resultado</button>
		</div>
	</form>
</body>
</html>