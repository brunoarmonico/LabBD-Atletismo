<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.List, model.Prova, controller.ControlaEvento" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="./resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<title>Novo Resultado</title>
</head>
<script>
$(document).ready(function(){
	$("#tempo").hide();
});

$(document).ready(function(){
	$("#prova").click(function(){
	var selecionado = $("#prova").val();
		if (selecionado <= 6) {
			$("#tempo").hide();
			$("#distancia").show();
		} else {
			$("#tempo").show();
			$("#distancia").hide();
		}
	});
});
</script>
<body>
	<% ControlaEvento cd = new ControlaEvento(); %>
	<% List<Prova> provas = cd.listarProvas(); %>
	<form action="./ControleAtletismo" method="post">
	<div>Codido do Atleta: <input type="text" name="codigo"/></div>
	<div>Prova: <select name="prova" id="prova">
	<% for (Prova lista : provas) { %>
	<option value="<% out.print(lista.getIdProva()); %>"> <% out.print(lista.getNomeProva()); %></option>
	<% } %>
	</select> </div>
	<div>Bateria: <select name="bateria">
			<option value="1"> 1 </option>
			<option value="2"> 2 </option>
			<option value="3"> 3 </option>		
	</select></div>
	<div id="tempo">Tempo: <input type="text" name="tempo" /></div>
	<div id="distancia">Distancia: <input type="text" name="distancia" /></div>
	<div>Fase: <select name="fase">
		<option value="inicial"> Inicial </option>
		<option value="final"> Final </option>
	</select></div>
	<button value="novoResultado" type="submit" name="botaoEnvio"> Adicionar </button>	
	</form>
</body>
</html>